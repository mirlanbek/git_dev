#!/bin/bash

source config
source functions.sh

iptables -F

echo "configure NET8  ip"

sleep 3


cat > /etc/sysconfig/network-scripts/ifcfg-$NIC2 << EOF
BOOTPROTO=static
NAME=$NIC2
DEVICE=$NIC2
ONBOOT=yes
IPADDR=$NEW_IP
NETMASK=255.255.255.0
EOF

echo "restart network"

reboot_network

sleep 3
echo "set hostname"
hostnamectl set-hostname $HOSTNAME

echo "install packages"

sleep 3
install_packages 

echo "instalation is DONE"



