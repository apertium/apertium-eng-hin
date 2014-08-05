#!/usr/bin/env bash

if [[ $2 = "hin-eng" ]]; then
echo "==Hindi->English===========================";
bash inconsistency.sh $1 hin-eng > /tmp/hin-eng.testvoc; bash inconsistency-summary.sh /tmp/hin-eng.testvoc hin-eng
echo ""
elif [[ $2 = "eng-hin" ]]; then
echo "==English->Hindi===========================";
bash inconsistency.sh $1 eng-hin > /tmp/eng-hin.testvoc; bash inconsistency-summary.sh /tmp/eng-hin.testvoc eng-hin
echo "";
fi
