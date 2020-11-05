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

h=`hostname`

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

sed -i s/ONBOOT=no/ONBOOT=on/ /etc/sysconfig/network-scripts/ifcfg-$NET1

restart_network

##install rpcbind, yp-tools, ypserv

yum install rpcbind yp-tools ypserv -y
sleep 3

systemctl start rpcbind ypserv ypxfrd

sleep 3

systemctl enable rpcbind ypserv ypxfrd

#configure local dns

cat > /etc/hosts << EOF
localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
$M_MANAGEMENT_IP nismaster
$C_MANAGEMENT_IP nisclient
EOF

if grep -q $DOMAIN /etc/yp.conf ; then

echo "bar eken e "
else
echo "ypserver nismaster" >> /etc/yp.conf
echo "domain $DOMAIN" >> /etc/yp.conf

fi

# configure nsswitch.conf


sed -i 's/passwd:     files sss/passwd:  nis files sss/' /etc/nsswitch.conf
sed -i 's/shadow:     files sss/shadow:  nis files sss/' /etc/nsswitch.conf
sed -i 's/group:      files sss/group:   nis files sss/' /etc/nsswitch.conf 


# starting nis master server
if [[ $h == $M_HOSTNAME  ]] ; then
	/usr/lib64/yp/ypinit -m
	sleep 1
	echo "start compileing with Make"
	pushd /var/yp 
	make
	popd
        systemctl restart ypbind
        systemctl enable ypbind
fi


echo "nis master is started"

sleep 1

 

if [[ $h == $C_HOSTNAME  ]] ; then
	/usr/lib64/yp/ypinit -s $M_HOSTNAME
	systemctl restart ypbind
	systemctl enable ypbind
fi

echo "nis client started"

sleep 1


ypcat passwd

### install nfs - utils

yum install nfs-utils -y

if [[ $cur_ip == $M_MANAGMENT_IP ]] ; then
cat > /etc/exports << EOF
/home $C_MANAGMENT_IP (rw,sync,no_root_squash)
EOF
fi
systemctl restart nfs-server
sleep 2
systemctl enable  nfs-server

###mounting the NFS folder
if [[ $cur_ip == $C_MANAGMENT_IP  ]] ; then
mount $M_MANAGMENT_IP:/home /mnt/

fi

#####setting up autofs

yum install autofs -y

sed -i '/\/home/d' /etc/auto.master
echo "/home /etc/auto.home" >> /etc/auto.master

sleep 2

cat > /etc/auto.home << EOF
*  $M_MANAGMENT_IP:/home/&

EOF

systemctl start autofs.service
systemctl enable autofs.service







