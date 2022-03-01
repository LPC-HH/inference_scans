#!/usr/bin/env bash

law run PlotLikelihoodScan \
    --hh-model "$MODEL_BOOSTED" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --pois C2V,CV \
    --scan-parameters C2V,-0.5,2.5,25:CV,-2,2,41 \
    --show-parameters kt,C2V \
    --file-types "pdf,png" \
    --campaign run2 \
    --y-log \
    --z-min 1e-3 \
    --z-max 1000 \
    --unblinded True  \
    --show-significances 1,2,3,5 \
    --shift-negative-values \
    --LikelihoodScan-workflow "htcondor" \
    --LikelihoodScan-tasks-per-job 1 \
    --use-snapshot True \
    --Snapshot-workflow "local" \
    --interpolate-above 999 \
    --interpolate-nans \
    --remove-output 0,a,y
