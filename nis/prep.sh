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

##configure enp0s3

# Please use sed command to change value 
cat > /etc/sysconfig/network-scripts/ifcfg-$NET1  <<EOF
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=dhcp
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=enp0s3
UUID=84ba1b44-dd48-439e-b03a-7747824aa529
DEVICE=enp0s3
ONBOOT=on

EOF
restart_network
