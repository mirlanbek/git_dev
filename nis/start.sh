#!/bin/bash

iptables -F

# copy all files to remote servers

for host in `cat hosts` ; do
    scp config	functions  prep.sh root@$host:~
done

echo "done coping files"
sleep 2


# Execute binaries

for host in $(cat hosts); do
    ssh root@$host 'cd && bash -x prep.sh | tee -a prep.log'
done

