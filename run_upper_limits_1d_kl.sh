#!/usr/bin/env bash

law run PlotUpperLimits \
    --hh-model "$MODEL_BOOSTED_MINIMAL" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --xsec fb \
    --pois r \
    --frozen-groups signal_norm_xsbr \
    --scan-parameters kl,-14,20,18 \
    --UpperLimits-workflow "htcondor" \
    --UpperLimits-tasks-per-job 1 \
    --file-types "pdf,png" \
    --campaign run2 \
    --unblinded True \
    --use-snapshot True \
    --Snapshot-workflow "local" \
    --y-log \
    --remove-output 0,a,y \
    --show-parameters "kt,C2V,CV" \
    --br bbbb \
    --save-ranges
