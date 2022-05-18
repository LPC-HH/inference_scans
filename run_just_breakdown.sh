#!/usr/bin/env bash

MODEL_STRING=${MODEL_BOOSTED_MINIMAL//./__}
C4bcomb_STRING=${C4bcomb//,/__}
C4bcomb_STRING=${C4bcomb_STRING//\//_}
DCARD="$DHI_STORE/CombineDatacards/$MODEL_STRING/$C4bcomb_STRING/m125.0/$VERSION/datacard.txt"
DCARDWGROUPS="$DHI_STORE/CombineDatacards/$MODEL_STRING/$C4bcomb_STRING/m125.0/$VERSION/datacard_withgroups.txt"
POI="r"
SCAN="r,-2,12,15"
DCARD_HASH="datacards_c5d35ed1a9"

# do subtraction
python subtract.py $DCARD_HASH $MODEL_BOOSTED_MINIMAL $POI $SCAN $VERSION
