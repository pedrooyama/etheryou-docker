#!/bin/bash
cp -r common/ ./etheryou-client/
cd etheryou-client/
docker build -t oyamapedro/etheryou-client .
