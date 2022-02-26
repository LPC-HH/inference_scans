#!/usr/bin/env bash

# export DHI_CMS_POSTFIX="Preliminary"

law run PlotUpperLimits \
    --hh-model "$MODEL_BOOSTED" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --xsec fb \
    --pois r \
    --frozen-groups signal_norm_xsbr \
    --scan-parameters C2V,-1,3,33 \
    --UpperLimits-workflow "htcondor" \
    --UpperLimits-tasks-per-job 1 \
    --file-types "pdf,png" \
    --campaign run2 \
    --unblinded True \
    --use-snapshot False \
    --Snapshot-workflow "local" \
    --y-log \
    --remove-output 0,a,y \
    --show-parameters "kt,C2V,CV" \
    --br bbbb \
    --save-ranges
