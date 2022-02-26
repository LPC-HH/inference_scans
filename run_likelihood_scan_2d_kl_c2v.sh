#!/usr/bin/env bash

law run PlotLikelihoodScan \
    --hh-model "$MODEL_BOOSTED" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --pois kl,C2V \
    --scan-parameters kl,-18,28,24:C2V,-1,3,17 \
    --show-parameters kt,CV \
    --file-types "pdf,png" \
    --campaign run2 \
    --y-log \
    --z-min 1e-3 \
    --z-max 1000 \
    --unblinded True  \
    --show-significances 1,2,3,5 \
    --shift-negative-values \
    --LikelihoodScan-workflow "htcondor" \
    --LikelihoodScan-tasks-per-job 4 \
    --use-snapshot True \
    --remove-output 0,a,y \
    --interpolate-above 999 \
    --interpolate-nans
