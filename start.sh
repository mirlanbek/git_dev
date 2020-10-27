#!/bin/bash

source config

echo "iptables -F"

iptables -F

# copy prep.sh file to client

scp -r prepare.sh config functions.sh $NET1_IP:/root
if [ $? != 0 ]; then 
	echo "sorry script is not copied"
	exit 1
else
	# run prepare script
	ssh $NET1_IP 'bash -x /root/prepare.sh'
fi




