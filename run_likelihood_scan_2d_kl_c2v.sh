#!/usr/bin/env bash

law run PlotLikelihoodScan \
    --hh-model "$MODEL_BOOSTED_MINIMAL_ALT3" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --pois kl,C2V \
    --scan-parameters kl,-20,30,26:C2V,-0.5,2.5,13 \
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
    --LikelihoodScan-tasks-per-job 5 \
    --use-snapshot True \
    --Snapshot-workflow "local" \
    --remove-output 0,a,y
