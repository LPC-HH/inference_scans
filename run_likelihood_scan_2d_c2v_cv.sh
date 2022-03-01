#!/usr/bin/env bash

export DHI_CMS_POSTFIX="Supplementary"
law run PlotLikelihoodScan \
    --hh-model "$MODEL_BOOSTED" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --pois C2V,CV \
    --scan-parameters C2V,-0.5,2.5,25:CV,-2,2,41 \
    --y-min -2 \
    --y-max 2 \
    --x-min -0.5 \
    --x-max 2.5 \
    --show-parameters kl,kt \
    --show-best-fit False \
    --show-box \
    --recompute-best-fit \
    --file-types "pdf,png" \
    --campaign run2 \
    --y-log \
    --unblinded True  \
    --show-significances 1,2,3 \
    --shift-negative-values \
    --LikelihoodScan-workflow "htcondor" \
    --LikelihoodScan-tasks-per-job 1 \
    --use-snapshot True \
    --Snapshot-workflow "local" \
    --interpolation-method rbf \
    --interpolate-above 999 \
    --interpolate-nans \
    --remove-output 0,a,y
