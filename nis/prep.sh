#/bin/bash

# This file is used  for preparing remote systems
# Author: Beka Tokonbekov
# all rights are reserverd 2020

iptables -F

cd $DEST

source functions
. config 

# set hostname

cur_ip=`ip a | grep 192.168.1.| awk {'print $2'} | cut -d "/" -f1`

if [[ $cur_ip == $M_MANAGMENT_IP ]]; then
     hostnamectl set-hostname $M_HOSTNAME
     NEW_IP=$M_IP
elif [[ $cur_ip == $C_MANAGMENT_IP ]]; then
     hostnamectl set-hostname $C_HOSTNAME
     NEW_IP=$C_IP
else
    echo "$cur_ip IP is not set in config"
fi

echo "Hostname successfully set"
sleep 2

# set domain name

domainname $DOMAIN


# Configure network
cat > /etc/sysconfig/network-scripts/ifcfg-$NET2 <<EOF
BOOTPROTO=static
NAME=$NET2
DEVICE=$NET2
ONBOOT=yes
IPADDR=$NEW_IP
NETMASK=255.255.255.0

EOF

restart_network
