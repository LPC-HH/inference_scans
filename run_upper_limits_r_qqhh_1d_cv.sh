#!/usr/bin/env bash

export DHI_CMS_POSTFIX="Supplementary"
law run PlotUpperLimits \
    --hh-model "$MODEL_BOOSTED_CLOSURE" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --xsec fb \
    --pois r_qqhh \
    --frozen-groups signal_norm_xsbr \
    --scan-parameters CV,-2,-1.9375,2:CV,-1.6875,-1.625,2:CV,-1.4375,-1.25,4:CV,-1.25,2,14 \
    --UpperLimits-workflow "htcondor" \
    --UpperLimits-tasks-per-job 1 \
    --file-types "pdf,png" \
    --campaign run2 \
    --unblinded True \
    --use-snapshot True \
    --Snapshot-workflow "local" \
    --y-log \
    --remove-output 0,a,y \
    --show-parameters "kl,kt,C2V" \
    --br bbbb \
    --save-ranges
