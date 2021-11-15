#!/bin/bash

calc() {
 awk "BEGIN { print "$*" }"
}

limit=0.9
validator_address="onexxxxxxxxxxxxx" # replace with your validator address
string=$(hmy blockchain validator information $validator_address --node="https://api.s0.t.hmny.io")
#echo "${string}"
signrate=$(echo $string | jq '.result ."current-epoch-performance" ."current-epoch-signing-percent" ."current-epoch-signing-percentage"')
echo $signrate

total_delegate=$(echo $string | jq '.result ."total-delegation"')
total_delegate_rounded=$(echo $total_delegate | awk '{print substr($0, 1, length($0)-18)}')
echo $total_delegate_rounded

delegators_count=$(echo $string | jq '.result .validator .delegations | map(select(.amount>0))' | jq length)
echo $delegators_count
text=""

result=$(calc $(echo $signrate | grep -o '[0-9]\.[0-9][0-9][0-9][0-9]'))

if [ 1 -eq "$(echo "${result} < ${limit}" | bc)" ]
then
 echo "⚠️ $result"
 text="✍️ $result ⚠️|👨👩👧👦 $delegators_count|🏦 $total_delegate_rounded"
elif [ 1 -eq "$(echo "${result} > ${limit}" | bc)" ]
then
 echo "✅ $result"
 text="✍️ $result ✅|👨👩👧👦 $delegators_count|🏦 $total_delegate_rounded"
fi

echo $result
# fill in chat_id with yours and your bot access token  
curl --data chat_id="0xxxxxxx" \
     --data "text=$text" \
     "https://api.telegram.org/botxxxxxxx:xxxxxxxxxxx/sendMessage"
