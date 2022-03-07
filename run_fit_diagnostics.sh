#!/usr/bin/env bash

law run FitDiagnostics \
    --hh-model "$MODEL_BOOSTED_CLOSURE" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --skip-b-only False \
    --pois r \
    --use-snapshot True \
    --unblinded True

law run FitDiagnostics \
    --hh-model "$MODEL_BOOSTED_CLOSURE" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --skip-b-only False \
    --pois r \
    --parameter-values C2V=0 \
    --use-snapshot True \
    --unblinded True
