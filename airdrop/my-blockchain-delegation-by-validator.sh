#!/bin/bash
hmy blockchain delegation by-validator "one_your_validator_address" --node="https://api.s0.t.hmny.io" | jq '.result | map(select(.amount>0))'
