import os
import sys
import math
import yaml
import logging
import argparse

logging.basicConfig(level=logging.DEBUG)


def subtract_in_quad(bigger, smaller):
    return math.sqrt(
        max(
            0,
            bigger * bigger - smaller * smaller
        )
    )


if __name__ == '__main__':
    # setup argument parsing
    parser = argparse.ArgumentParser(description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)

    parser.add_argument("datacard", metavar="DATACARD", help="input datacard")
    parser.add_argument("model", metavar="MODEL", help="model")
    parser.add_argument("poi", metavar="POI", help="POI (r or kl)")
    parser.add_argument("scan", metavar="SCAN", help="scan range")
    parser.add_argument("label", metavar="LABEL", help="label")
    args = parser.parse_args()

    datacards = args.datacard
    model = args.model.replace('.', '__')
    label = args.label
    scan = args.scan.split(',')
    poi = args.poi

    scan_range = {}
    other_params = {}
    other_params["kl"] = "params_r1.0_r_gghh1.0_r_qqhh1.0_kt1.0_CV1.0_C2V1.0"
    other_params["r"] = "params_r_gghh1.0_r_qqhh1.0_kl1.0_kt1.0_CV1.0_C2V1.0"

    scan_range[poi] = "scan_{}_{:.1f}_{:.1f}_n{:d}".format(
        scan[0], 
        float(scan[1]), 
        float(scan[2]), 
        int(scan[3])
    )

    store = os.environ["DHI_STORE"]

    groups = [
        "THY", 
        "LUMI", 
        "MCSTAT", 
        "TTBAR", 
        "BBTAG", 
        "JMRJMSJERJES",
        "PU", 
        "TRIG", 
        "OTHER",
        "QCD",
    ]

    paths = {}
    jsons = {}
    paths["TOTAL"] = "{store}/PlotLikelihoodScan/{model}/{datacards}/m125.0/poi_{poi}/{label}/ranges__unblinded__poi_{poi}__{scan}__{params}__fromsnapshot.json".format(
        store=store,
        model=model,
        datacards=datacards,
        poi=poi,
        label=label,
        scan=scan_range[poi],
        params=other_params[poi]
    )
    jsons["TOTAL"] = yaml.safe_load(open(paths["TOTAL"]))

    paths["STAT"] = paths["TOTAL"].replace(
        "fromsnapshot.json",
        "fzp_allConstrainedNuisances__fromsnapshot.json"
    )
    jsons["STAT"] = yaml.safe_load(open(paths["STAT"]))


    paths["PURESTAT"] = paths["TOTAL"].replace(
        "fromsnapshot.json",
        "fzp_allConstrainedNuisances__fzg_QCD__fromsnapshot.json"
    )
    jsons["PURESTAT"] = yaml.safe_load(open(paths["PURESTAT"]))

    nom = float(jsons["TOTAL"][poi]["best_fit"])
    up_err = {}
    down_err = {}
    up_err["TOTAL"] = float(jsons["TOTAL"][poi]["uncertainty"][0][0])
    down_err["TOTAL"] = float(jsons["TOTAL"][poi]["uncertainty"][0][1])

    up_err["STAT"] = float(jsons["STAT"][poi]["uncertainty"][0][0])
    down_err["STAT"] = float(jsons["STAT"][poi]["uncertainty"][0][1])

    up_err["PURESTAT"] = float(jsons["PURESTAT"][poi]["uncertainty"][0][0])
    down_err["PURESTAT"] = float(jsons["PURESTAT"][poi]["uncertainty"][0][1])

    up_err["SYST"] = subtract_in_quad(up_err["TOTAL"], up_err["STAT"])
    down_err["SYST"] = -subtract_in_quad(down_err["TOTAL"], down_err["STAT"])

    for group in groups:
        paths[group] = paths["TOTAL"].replace(
            "fromsnapshot.json",
            "fzg_{group}__fromsnapshot.json".format(
                group=group
            )
        )
        jsons[group] = yaml.safe_load(open(paths[group]))
        up_err_fzg = float(jsons[group][poi]["uncertainty"][0][0])
        down_err_fzg = float(jsons[group][poi]["uncertainty"][0][1])
        up_err[group] = subtract_in_quad(up_err["TOTAL"], up_err_fzg)
        down_err[group] = -subtract_in_quad(down_err["TOTAL"], down_err_fzg)

        logging.info("freeze {key:12}: {poi} = {nom:5.4f} {up_err:+5.4f}/{down_err:+5.4f}".format(
            key=group,
            poi=poi,
            nom=nom,
            up_err=up_err_fzg,
            down_err=down_err_fzg
        )
        )

    for key in sorted(up_err, key=up_err.get, reverse=True):
        percent = 100.*(up_err[key] - down_err[key]) / (2*nom)
        logging.info("{key:12}: {poi} = {nom:5.4f} {up_err:+5.4f}/{down_err:+5.4f}: {percent:3.0f}% w.r.t. central value (symmetrized)".format(
            key=key,
            poi=poi,
            nom=nom,
            up_err=up_err[key],
            down_err=down_err[key],
            percent=percent
            )
        )
