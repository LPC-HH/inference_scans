#!/usr/bin/env bash

law run Snapshot \
    --hh-model "$MODEL_BOOSTED_CLOSURE" \
    --version "$VERSION" \
    --datacards "$C4bcomb" \
    --pois kl,C2V \
    --unblinded True \
    --remove-output 0,a,y
