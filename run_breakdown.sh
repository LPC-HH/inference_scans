#!/usr/bin/env bash

MODEL_STRING=${MODEL_BOOSTED_MINIMAL//./__}
C4bcomb_STRING=${C4bcomb//,/__}
C4bcomb_STRING=${C4bcomb_STRING//\//_}
DCARD="$DHI_STORE/CombineDatacards/$MODEL_STRING/$C4bcomb_STRING/m125.0/$VERSION/datacard.txt"
DCARDWGROUPS="$DHI_STORE/CombineDatacards/$MODEL_STRING/$C4bcomb_STRING/m125.0/$VERSION/datacard_withgroups.txt"
POI="r"
SCAN="r,-2,12,15"
DCARD_HASH="datacards_c5d35ed1a9"

# make card with groups
python add_nuisance_groups.py $DCARD $DCARDWGROUPS

# get stat-only
for p in "allConstrainedNuisances"; do
    for g in "" "QCD"; do
        law run PlotLikelihoodScan \
            --version "$VERSION" \
            --hh-model "$MODEL_BOOSTED_MINIMAL" \
            --datacards "$DCARDWGROUPS" \
            --pois "$POI" \
            --scan-parameters "$SCAN" \
            --file-types "pdf,png" \
            --campaign run2 \
            --workers 8 \
            --unblinded True \
            --use-snapshot True \
            --shift-negative-values \
            --y-max 10 \
            --frozen-groups "$g" \
            --frozen-parameters "$p" \
            --Snapshot-frozen-parameters "" \
            --Snapshot-frozen-groups "" \
            --remove-output 0,a,y \
            --save-ranges True
    done
done
# get systematic/theory breakdowns
for p in ""; do
    for g in "" "THY" "LUMI" "MCSTAT" "TTBAR" "BBTAG" "JMRJMSJERJES" "PU" "TRIG" "OTHER" "QCD"; do
        law run PlotLikelihoodScan \
            --version "$VERSION" \
            --hh-model "$MODEL_BOOSTED_MINIMAL" \
            --datacards "$DCARDWGROUPS" \
            --pois "$POI" \
            --scan-parameters "$SCAN" \
            --file-types "pdf,png" \
            --campaign run2 \
            --workers 8 \
            --unblinded True \
            --use-snapshot True \
            --shift-negative-values \
            --y-max 10 \
            --frozen-groups "$g" \
            --frozen-parameters "$p" \
            --Snapshot-frozen-parameters "" \
            --Snapshot-frozen-groups "" \
            --remove-output 0,a,y \
            --save-ranges True
    done
done

# do subtraction
python subtract.py $DCARD_HASH $MODEL_BOOSTED_MINIMAL $POI $SCAN $VERSION