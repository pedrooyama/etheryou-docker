#!/bin/bash
cp -r common/ ./etheryou-blockchain/
cd etheryou-blockchain/
docker build -t oyamapedro/etheryou-blockchain .

