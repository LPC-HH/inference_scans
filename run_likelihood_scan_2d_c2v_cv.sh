#!/usr/bin/env bash

export DHI_CMS_POSTFIX="Supplementary"
law run PlotLikelihoodScan \
    --hh-model "$MODEL_BOOSTED_CLOSURE" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --pois C2V,CV \
    --scan-parameters C2V,-0.5,2.5,97:CV,-2,2,81 \
    --y-min -2 \
    --y-max 2 \
    --x-min -0.5 \
    --x-max 2.5 \
    --show-parameters kl,kt \
    --show-best-fit False \
    --show-best-fit-error False \
    --recompute-best-fit True \
    --file-types "pdf,png" \
    --campaign run2 \
    --y-log \
    --unblinded True  \
    --show-significances 1,2,3 \
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
