#!/usr/bin/env bash

law run PlotPullsAndImpacts \
    --version "$VERSION" \
    --hh-model "$MODEL_BOOSTED_MINIMAL" \
    --datacards "$C4bcomb" \
    --pois r \
    --mc-stats \
    --PullsAndImpacts-workflow "htcondor" \
    --PullsAndImpacts-tasks-per-job 10 \
    --unblinded True \
    --use-snapshot True \
    --parameters-per-page 40 \
    --order-by-impact \
    --file-types "pdf,png" \
    --page 0 \
    --campaign run2 \
    --pull-range 3 \
    --remove-output 0,a,y
