# Delegators snapshot & airdrop bash scripts.

I was looking for a way to airdrop to my delegators & thanks to `johnashu` I found this https://github.com/johnashu/Harmony-Airdrop . But the addresses input is in `0x...` format, so I have to find a way to 1) snapshot my delegators addresses 2) convert these addresses from `one...` format to `0x...` format in order to use them with `johnashu` JS scripts, and here are the scripts I came up with. For modularity purpose, I split it into multiple scripts, I also assume `hmy` CLI is symlinked.

1) edit your validator address in `my-blockchain-delegation-by-validator.sh` . This script will return the list of your delegators with a delegated amount bigger than 0.
2) edit your working directory in `snapshot-delegators.sh` . This script will execute `my-blockchain-delegation-by-validator.sh`, then save the result in `[current_running_epoch].json`, for example `774.json`  
3) `extract.sh` takes 1 in put argument, for example:
```
./extract.sh 774
```
will extract the list of `one...` addresses, then save the result in `774_one.txt`, the file will look like:
```
one13kyypuaczvz7jdl64lht99m0xfqekxd3fcu2pm
one1t5necyk0sxlzt4w4zq62jcmy29gj7vt9sq0f66
one194hfumyvjmsqqhecjwrwpzkpkzefru9kt0uyqt
...
```
4) `convert.sh` takes 1 in put argument, for example:
```
./convert.sh 774
```
will read the file `774_one.txt`, add a 2nd colummn which is the corresponding `0x...` format of the 1st column in `one...` format, then save the result in `774_addresses.csv`, the file will look like:
```
one13kyypuaczvz7jdl64lht99m0xfqekxd3fcu2pm,0x8d8840F3b81305E937FaaFEEb2976f32419b19b1
one1t5necyk0sxlzt4w4zq62jcmy29gj7vt9sq0f66,0x5d279C12Cf81BE25D5D51034A9636451512F3165
one194hfumyvjmsqqhecjwrwpzkpkzefru9kt0uyqt,0x2D6E9E6c8c96e0005f389386e08Ac1B0b291F0b6
...
```
Finally you can use this file with johnashu's script to perform airdrop for your delegators (the script uses the 2nd column for destination addresses). 