#!/usr/bin/env bash

law run PlotMultipleLikelihoodScans \
    --hh-model "$MODEL_BOOSTED" \
    --version "$VERSION" \
    --multi-datacards "$C4bcomb:$C4bcomb:$C4bggf:$C4bggf:$C4bvbf:$C4bvbf" \
    --pois kl \
    --scan-parameters kl,-14,28,43 \
    --LikelihoodScan-workflow "htcondor" \
    --datacard-names "Comb. (exp.),Comb. (obs.),ggF (exp.),ggF (obs.),VBF (exp.),VBF (obs.)" \
    --campaign run2 \
    --file-types "pdf,png" \
    --interpolate-nans \
    --shift-negative-values \
    --recompute-best-fit \
    --unblinded False,True,False,True,False,True \
    --use-snapshot False \
    --Snapshot-workflow "local" \
    --remove-output 0,a,y \
    --y-log False
