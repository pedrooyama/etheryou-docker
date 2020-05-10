#!/bin/bash
. common/config.sh
docker run --rm -it --name $BLOCKCHAIN_HOST oyamapedro/etheryou-blockchain
