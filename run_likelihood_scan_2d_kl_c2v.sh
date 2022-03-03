#!/usr/bin/env bash

law run PlotLikelihoodScan \
    --hh-model "$MODEL_BOOSTED" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --pois kl,C2V \
    --scan-parameters kl,-20,30,101:C2V,-0.5,2.5,97 \
    --y-min -0.5 \
    --y-max 2.5 \
    --x-min -17 \
    --x-max 28 \
    --show-parameters kt,CV \
    --show-best-fit True \
    --show-best-fit-error False \
    --recompute-best-fit True \
    --file-types "pdf,png" \
    --campaign run2 \
    --paper \
    --y-log \
    --unblinded True  \
    --show-significances 1,2,3,5 \
    --shift-negative-values \
    --LikelihoodScan-workflow "htcondor" \
    --LikelihoodScan-tasks-per-job 10 \
    --LikelihoodScan-htcondor-cpus 2 \
    --LikelihoodScan-max-runtime 48h \
    --workers 4 \
    --use-snapshot True \
    --Snapshot-workflow "local" \
    --remove-output 0,a,y
    #--interpolate-above 999 \
    #--interpolate-nans \
    #--interpolation-method rbf,multiquadric,0.2

