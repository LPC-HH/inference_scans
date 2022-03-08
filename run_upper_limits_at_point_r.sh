#!/usr/bin/env bash

export DHI_CMS_POSTFIX="Supplementary"
law run PlotUpperLimitsAtPoint \
    --hh-model "$MODEL_BOOSTED_CLOSURE" \
    --version "$VERSION" \
    --multi-datacards "$MULTICARDS" \
    --file-types "pdf,png" \
    --pois r \
    --show-parameters kl,kt,C2V,CV \
    --UpperLimits-workflow "htcondor" \
    --UpperLimits-tasks-per-job 1 \
    --datacard-names "$MULTINAMES" \
    --x-log \
    --campaign run2 \
    --use-snapshot True \
    --Snapshot-workflow "local" \
    --unblinded True \
    --remove-output 0,a,y \
    --h-lines 1 \
    --datacard-order 4,3,2,1,0
