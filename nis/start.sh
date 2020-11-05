#!/bin/bash

iptables -F

. config

hosts=($M_MANAGMENT_IP $C_MANAGMENT_IP)

for host in ${hosts[@]} ; do
	if grep -q $host ~/.ssh/known_hosts ; then
		 sed -i /$host/d ~/.ssh/known_hosts
	fi
	sshpass -p '1' ssh-copy-id -o "StrictHostKeyChecking no" root@$host
done

# copy all files to remote servers

for host in  ${hosts[@]} ; do
    scp config	functions  prep.sh root@$host:~
done

echo "done coping files"
sleep 2


# Execute binaries

for host in ${hosts[@]} ; do
    ssh root@$host 'cd && bash -x prep.sh | tee -a prep.log'
done

