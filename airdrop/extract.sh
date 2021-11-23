#/bin/bash
echo "Extracting one addresses from file $1.json ..."
cat $1.json | jq -r '.[] | ."delegator_address"' > $1_one.txt
echo "one addresses saved to $1_one.txt !"
