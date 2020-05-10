#!/bin/sh
. ./config.sh
HOME=/src/app

set -m

apk add git
npm install truffle -g

cd $HOME
git clone $GIT_REPO

mkdir truffle
cd truffle

truffle init
cp $HOME/etheryou/smart_contract/$CONTRACT.sol $HOME/truffle/contracts/
cp $HOME/1_initial_migration.js $HOME/truffle/migrations/
cp $HOME/truffle-config.js $HOME/truffle

sed -i "s/__GANACHE_PORT__/${GANACHE_PORT}/g" $HOME/truffle/truffle-config.js
sed -i "s/__NETWORK_ID__/${NETWORK_ID}/g" $HOME/truffle/truffle-config.js
sed -i "s/__NETWORK_NAME__/${NETWORK_NAME}/g" $HOME/truffle/truffle-config.js

node $GANACHE_JS --networkId=$NETWORK_ID -p $GANACHE_PORT --account=$PRIVATE_KEY_A,$TEST_ACCOUNTS_BALANCE --account=$PRIVATE_KEY_B,$TEST_ACCOUNTS_BALANCE &

truffle deploy --network $NETWORK_NAME

contract_address=`truffle networks | grep $CONTRACT | grep -o 0x.*`
sed -i "s/__CONTRACT_ADDRESS__/${contract_address}/g" $CONTRACT_ADDRESS_SERVER_FILE
sed -i "s/__CONTRACT_ADDRESS_SERVER_PORT__/${CONTRACT_ADDRESS_SERVER_PORT}/g" $CONTRACT_ADDRESS_SERVER_FILE


node $CONTRACT_ADDRESS_SERVER_FILE &

echo -e "\033[0;32mBLOCKCHAIN READY!\033[0m"

fg %1
