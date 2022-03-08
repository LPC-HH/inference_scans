#!/usr/bin/env bash

#export DHI_CMS_POSTFIX="Preliminary"
law run PlotLikelihoodScan \
    --hh-model "$MODEL_BOOSTED_ALL_NO_KL_M3" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --pois kl,C2V \
    --scan-parameters kl,-26,36,125:C2V,-0.5,2.5,97 \
    --y-min -0.5 \
    --y-max 2.5 \
    --x-min -24 \
    --x-max 34 \
    --show-parameters kt,CV \
    --show-best-fit True \
    --show-best-fit-error False \
    --recompute-best-fit True \
    --file-types "pdf,png" \
    --campaign run2 \
    --y-log \
    --z-min 0.01 \
    --z-max 10000 \
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
    --interpolation-method rbf,multiquadric,1,0.2 \
    --paper

