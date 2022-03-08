#!/usr/bin/env bash

export DHI_CMS_POSTFIX="Supplementary"
law run PlotLikelihoodScan \
    --hh-model "$MODEL_BOOSTED_CLOSURE" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --pois C2V,CV \
    --scan-parameters C2V,-1,3,129:CV,-3,3,121 \
    --y-min -2.5 \
    --y-max 3 \
    --x-min -1 \
    --x-max 3 \
    --show-parameters kl,kt \
    --show-best-fit True \
    --show-best-fit-error False \
    --recompute-best-fit True \
    --file-types "pdf,png" \
    --campaign run2 \
    --y-log \
    --z-min 0.0001 \
    --z-max 100000 \
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
    --remove-output 0,a,y \
    --interpolate-above 999 \
    --interpolate-nans \
    --interpolation-method rbf,multiquadric
