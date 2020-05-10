#!/bin/bash
. ./config.sh
script=$1
output_dir=$2
HOME=/src/app


apt-get update
apt install -y npm curl
npm install truffle -g

cd $HOME
git clone $GIT_REPO
mkdir $VOLUME_REPORT_DIR
mkdir $ETHERYOU_EXPERIMENTS_OUTPUT_DIR

mkdir truffle
cd truffle
truffle init
cp $HOME/etheryou/smart_contract/$CONTRACT.sol $HOME/truffle/contracts/
truffle build
 
contract_address=`curl $BLOCKCHAIN_HOST:$CONTRACT_ADDRESS_SERVER_PORT`
sed -i "s/__CONTRACT_ADDRESS__/${contract_address}/g" $ETHERYOU_CONFIG_FILE

truffle_file_path="$HOME/truffle/build/contracts/$CONTRACT.json"
sed -i "s#__TRUFFLE_FILE_PATH__#${truffle_file_path}#g" $ETHERYOU_CONFIG_FILE

experiments_output_dir=$output_dir
mkdir $experiments_output_dir
sed -i "s#__EXPERIMENTS_DIR__#${experiments_output_dir}#g" $ETHERYOU_CONFIG_FILE


rpc_server="http://$BLOCKCHAIN_HOST:$GANACHE_PORT"
sed -i "s#__RPC_SERVER__#${rpc_server}#g" $ETHERYOU_CONFIG_FILE


sed  -i "s#__PRIVATE_KEY_A__#${PRIVATE_KEY_A}#g" $ETHERYOU_USERS_FILE
sed  -i "s#__PUBLIC_KEY_A__#${PUBLIC_KEY_A}#g" $ETHERYOU_USERS_FILE
sed  -i "s#__PRIVATE_KEY_B__#${PRIVATE_KEY_B}#g" $ETHERYOU_USERS_FILE
sed  -i "s#__PUBLIC_KEY_B__#${PUBLIC_KEY_B}#g" $ETHERYOU_USERS_FILE

cd $HOME/etheryou
pip install -r requirements.txt
export set PYTHONPATH=.

python $script
