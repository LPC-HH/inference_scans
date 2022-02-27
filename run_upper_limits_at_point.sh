#!/usr/bin/env bash

law run PlotUpperLimitsAtPoint \
    --hh-model "$MODEL_BOOSTED_MINIMAL" \
    --version "$VERSION" \
    --multi-datacards "$MULTICARDS" \
    --file-types "pdf,png" \
    --pois r \
    --UpperLimits-workflow "htcondor" \
    --UpperLimits-tasks-per-job 1 \
    --datacard-names "$MULTINAMES" \
    --x-log \
    --campaign run2 \
    --use-snapshot True \
    --Snapshot-workflow "local" \
    --unblinded True \
    --remove-output 0,a,y \
    --datacard-order 4,3,2,1,0
