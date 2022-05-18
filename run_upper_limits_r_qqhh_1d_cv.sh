#!/usr/bin/env bash

export DHI_CMS_POSTFIX="Supplementary"
law run PlotUpperLimits \
    --hh-model "$MODEL_BOOSTED_CLOSURE" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --xsec fb \
    --pois r_qqhh \
    --frozen-groups signal_norm_xsbr \
    --scan-parameters CV,-2,-1.75,9:CV,-1.75,-0.625,73:CV,-0.546875,-0.546875,1:CV,-0.34375,-0.34375,1:CV,-0.28125,2,147 \
    --UpperLimits-workflow "htcondor" \
    --UpperLimits-tasks-per-job 1 \
    --file-types "pdf,png" \
    --campaign run2 \
    --unblinded True \
    --use-snapshot False \
    --Snapshot-workflow "local" \
    --y-log \
    --remove-output 0,a,y \
    --show-parameters "kl,kt,C2V" \
    --br bbbb \
    --save-ranges \
    --save-hep-data True
