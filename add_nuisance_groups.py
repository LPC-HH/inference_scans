import os
import numpy as np
from collections import OrderedDict
import argparse

from dhi.datacard_tools import manipulate_datacard
from dhi.util import create_console_logger

logger = create_console_logger(os.path.splitext(os.path.basename(__file__))[0])
logger.setLevel("INFO")

if __name__ == '__main__':

    # setup argument parsing
    parser = argparse.ArgumentParser(description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)

    parser.add_argument("input", metavar="INPUTDATACARD", help="input datacard")
    parser.add_argument("output", metavar="OUTPUTDATACARD", help="output datacard")
    args = parser.parse_args()

    datacard = args.input
    target_datacard = args.output

    proc_mcstat_to_skip = [
        "ggHH_kl_0_kt_1",
        "qqHH_CV_0p5_C2V_1_kl_1",
        "boosted_ggHH_kl_0_kt_1",
        "boosted_ggHH_kl_2p45_kt_1",
        "boosted_ggHH_kl_5_kt_1",
        "boosted_qqHH_CV_0p5_C2V_1_kl_1",
        "boosted_qqHH_CV_1p5_C2V_1_kl_1",
        "boosted_qqHH_CV_1_C2V_1_kl_2",
        "boosted_qqHH_CV_1_C2V_1_kl_0",
        "boosted_qqHH_CV_1_C2V_2_kl_1"
    ]

    with manipulate_datacard(datacard, target_datacard, read_structured=True) as (blocks, content):
        bin_names = blocks["rates"][0].split()[1:]
        process_names = blocks["rates"][1].split()[1:]
        process_ids = blocks["rates"][2].split()[1:]
        rates = blocks["rates"][3].split()[1:]
        all_bin_names = [p["name"] for p in content["bins"]]
        all_bin_rates = np.array([content['observations'][bin_name] for bin_name in all_bin_names], dtype=np.int)

        groups = {}
        # theory
        THY = [
            "THU_HH",
            "m_top_unc_ggHH", 
            "alpha_s_ggHH",
            "alpha_s",
            "BR_hbb", 
            "pdf_Higgs_ggHH", 
            "pdf_Higgs_qqHH",
            "pdf_Higgs_qqbar",
            "QCDscale_qqHH",
            "QCDscale_ttH",
            "QCDscale_VH",
            "pdf_Higgs_ttH",
            "qqHH_pythiaDipoleOn",
            "ps_isr",
            "ps_fsr",
            "CMS_bbbb_boosted_vbf_isr_ggHH",
            "CMS_bbbb_boosted_vbf_isr_qqHH",
            "CMS_bbbb_boosted_vbf_isr_ttbar",
            "CMS_bbbb_boosted_ggf_ps_isr_others",
            "CMS_bbbb_boosted_ggf_ps_fsr_others",
            "CMS_bbbb_boosted_ggf_ggHHPDFacc",
            "CMS_bbbb_boosted_ggf_ggHHQCDacc",
            "CMS_bbbb_boosted_ggf_othersQCD",
            "CMS_bbbb_boosted_ggf_mHHTHunc"
        ]
        groups["THY"] = []
        # syst
        groups["LUMI"] = []
        groups["MCSTAT"] = []
        groups["TTBAR"] = []
        groups["BBTAG"] = []
        groups["JMRJMSJERJES"] = []
        groups["PU"] = []
        groups["TRIG"] = []
        groups["OTHER"] = []
        # stat
        groups["QCD"] = []

        for parameter in content["parameters"]:
            param_name  = parameter["name"]
            param_type  = parameter["type"]
            param_spec  = parameter["spec"]
            # if parameter already added to a group, continue
            if "lumi" in param_name:
                groups["LUMI"].append(param_name)
            elif "CMS_pileup" in param_name:
                groups["PU"].append(param_name)
            elif "CMS_HEM" in param_name or "CMS_l1_ecal" in param_name or "PUJET" in param_name:
                groups["OTHER"].append(param_name)
            elif param_name in THY:
                groups["THY"].append(param_name)
            elif ("prop_CMS_bbbb_boosted_vbf" in param_name) or "mcstat" in param_name or "MCStats" in param_name:
                if any([proc in param_name for proc in proc_mcstat_to_skip]):
                    print("Skipping: {}".format(param_name))
                    continue
                groups["MCSTAT"].append(param_name)
            elif "qcdparam_msdbin" in param_name or "tf_dataResidual" in param_name:
                groups["QCD"].append(param_name)
            elif ("_a_" in param_name or "_b_" in param_name or "_c_" in param_name or "_d_" in param_name) and ("@" not in param_spec[2]):
                # if it's not a function add it to the group
                groups["QCD"].append(param_name)
            elif "bbmistag" in param_name or "bbtag" in param_name or "PNet" in param_name:
                groups["BBTAG"].append(param_name)
            elif "jmr" in param_name:
                groups["JMRJMSJERJES"].append(param_name)
            elif "jms" in param_name:
                groups["JMRJMSJERJES"].append(param_name)
            elif "CMS_scale_j" in param_name:
                groups["JMRJMSJERJES"].append(param_name)
            elif "CMS_res_j" in param_name:
                groups["JMRJMSJERJES"].append(param_name)
            elif "trig" in param_name:
                groups["TRIG"].append(param_name)
            elif "ttbar" in param_name or "ttJets" in param_name:
                groups["TTBAR"].append(param_name)
            else:
                print("Leftover: {}".format(param_name))

        for group, params in groups.items():
            group_string = "{}  group  =  {}".format(group, "  ".join(params))
            blocks["parameters"].append(group_string)