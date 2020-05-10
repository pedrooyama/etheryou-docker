#!/bin/bash
. common/config.sh

while true; do
	echo "Select the script you want to execute:"
	echo "[0] EtherYou Client Software"
	echo "[1] Experiment Gas x Message Length"
	echo "[2] Experiment Gas x Number of Recipients"
	read -p "-->" option
	    case $option in
	        0 ) script='main/run.py';break;;
	        1 ) script='experiments/gas_x_message_length.py';break;;
	        2 ) script='experiments/gas_x_number_of_recipients.py';break;;
	        * ) echo "Please select a valid option."; echo "";;
	    esac
done

if [[ ( "$option" == 1 ) || ( "$option" == 2 ) ]] ; then
    read -p "Enter the directory in which the experiment results must be saved: " output_dir
    volume="-v $output_dir:$VOLUME_REPORT_DIR"
else
    volume=""
fi

echo "Initialising client container..."
docker run $volume --link $BLOCKCHAIN_HOST --rm -it oyamapedro/etheryou-client $script $VOLUME_REPORT_DIR


