#!/usr/bin/env bash

export DHI_CMS_POSTFIX="Supplementary"
law run PlotMultipleUpperLimits \
    --hh-model "$MODEL_BOOSTED_CLOSURE" \
    --version "$VERSION" \
    --multi-datacards "$C4bcomb:$C4bggf:$C4bvbf" \
    --datacard-names "Combined,ggF cat.,VBF cat." \
    --xsec fb \
    --pois r \
    --frozen-groups signal_norm_xsbr \
    --scan-parameters CV,-2,2,129 \
    --UpperLimits-workflow "htcondor" \
    --UpperLimits-tasks-per-job 1 \
    --file-types "pdf,png" \
    --campaign run2 \
    --unblinded True \
    --use-snapshot True \
    --Snapshot-workflow "local" \
    --y-log \
    --remove-output 0,a,y \
    --show-parameters "kl,kt,CV" \
    --br bbbb \
    --save-ranges
