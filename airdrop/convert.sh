#!/bin/bash

FILENAME="$1_one.txt"
LINES=$(cat $FILENAME)

echo "Converting one addresses from file $1_one.txt ..."

for LINE in $LINES
do
#    echo "$LINE"
 addr_hex=$(hmy utility bech32-to-addr $LINE)
 echo "$LINE,$addr_hex" >> $1_addresses.csv
done

echo "one addresses & 0x addresses saved to $1_addresses.txt !"
