#!/bin/bash
epoch=$(hmy blockchain latest-headers | jq '.result ."beacon-chain-header" .epoch')
echo "snapshot epoch $epoch"
/home/$USER/Harmony/mainnet/my-blockchain-delegation-by-validator.sh > /home/$USER/Harmony/mainnet/delegators/$epoch.json
