#!/usr/bin/env bash

law run FitDiagnostics \
    --hh-model "$MODEL_BOOSTED_CLOSURE" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --pois r \
    --use-snapshot True \
    --unblinded True \
    --remove-output 0,a,y
