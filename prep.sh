#!/bin/bash
## venera salam
echo "10.11.12.7:/backup /mnt/nfs				nfs	defaults	0 0" >> /etc/fstab 
if [ -e /tf  ]
then
rm -rf /tf/*
else
mkdir /tf
fi
cd /tf/

cp /mnt/nfs/sunrise-trail/scripts/dev/stack-install-scripts.tar.gz .
tar zxf *
cd /tf/stack-install-scripts

read -p "Are going to use existing sample-onps_config template? answer \"y\" or \"n\": " template

#################################################################
if [ $template == "y" ] #start IF-1
then
################################################################o#


cp -rf /mnt/nfs/users/mirlan/conf/sample-onps_config onps_config #here you have to have your own onps_config template

#Start script

# node type
echo -n "Enter node type. controller or compute: "

read node_type

old_node_type=`grep node_type onps_config`

sed -i "s/$old_node_type/node_type=$node_type/"  onps_config

# ODL type
read -p "is this gonna be ODL ?? answer \"y\" or \"n\":  " odl_type

case $odl_type in
y|yes|Yes|YES) 

sed -i "s/use_odl=no/use_odl=yes/"  onps_config
;;
n|no|No|NO) echo "you chose NO";;
*)echo "you chose something else, and bye for now !!!" 
exit 1 
;;
esac

# ovs-type

echo -n "Enter OVS type. ovs or ovs-dpdk: "

read ovs_type

old_ovs_type=`grep ovs_type= onps_config`

sed -i "s/$old_ovs_type/ovs_type=$ovs_type/"  onps_config

echo -n "Enter controller's Ip address: "
#asign ip addr
read controller_ip

old_ip=`grep controller_ip onps_config`

sed -i "s/$old_ip/controller_ip=$controller_ip/"  onps_config

#change hostmame

read -p "enter controller's hostname: " controller_hostname
old_contr_hostname=`grep controller_name onps_config`

sed -i "s/$old_contr_hostname/controller_name=$controller_hostname/"  onps_config


#change hostmame

read -p "enter this machine's hostname: " hostname
old_hostname=`grep host_name onps_config`

sed -i "s/$old_hostname/host_name=$hostname/"  onps_config


#change mgmt_ip_addr

read -p "enter mgmt_ip_addr: " mgmnt_ip
old_mgmnt_ip=`grep mgmt_ip_addr onps_config`

sed -i "s/$old_mgmnt_ip/mgmt_ip_addr=$mgmnt_ip/"  onps_config


#change tunnel_ip_addr

read -p "enter tunnel_ip: " tunnel_ip
old_tunnel_ip=`grep  tunnel_ip= onps_config`

sed -i "s/$old_tunnel_ip/tunnel_ip=$tunnel_ip/"  onps_config

#########################################################################
elif [ $template == "n" ] 
then
########################################################################

# node type
echo -n "Enter node type. controller or compute: "

read node_type

old_node_type=`grep node_type onps_config`

sed -i "s/$old_node_type/node_type=$node_type/"  onps_config


#ODL type
read -p "is this gonna be ODL?? answer \"y\" or \"n\":  " odl_type

case $odl_type in
y|yes|Yes|YES) 

sed -i "s/use_odl=no/use_odl=yes/"  onps_config
;;
n|no|No|NO) echo "you chose NO";;
*)echo "you chose something else, and bye for now !!!"
exit 1
;;
esac
# ovs-type

echo -n "Enter OVS type. ovs or ovs-dpdk: "

read ovs_type

old_ovs_type=`grep ovs_type= onps_config`

sed -i "s/$old_ovs_type/ovs_type=$ovs_type/"  onps_config


#asign tenant network
read -p "Enter Tenant network type \"vxlan\" or \"vlan\": " tenant_network

old_tenant_network=`grep tenant_network_type onps_config`

sed -i "s/$old_tenant_network/tenant_network_type=$tenant_network/"  onps_config


#asign ip addr
echo -n "Enter controller's Ip address: "
read controller_ip

old_ip=`grep controller_ip onps_config`

sed -i "s/$old_ip/controller_ip=$controller_ip/"  onps_config

#change hostmame

read -p "enter controller's hostname: " controller_hostname
old_contr_hostname=`grep controller_name onps_config`

sed -i "s/$old_contr_hostname/controller_name=$controller_hostname/"  onps_config


#change hostmame

read -p "enter this machine's hostname: " hostname
old_hostname=`grep host_name onps_config`

sed -i "s/$old_hostname/host_name=$hostname/"  onps_config


#change mgmt_NIC_name

read -p "enter mgmt_NIC_name: " mgmnt_if
old_mgmt_if=`grep mgmt_net_if onps_config`

sed -i "s/$old_mgmt_if/mgmt_net_if=$mgmnt_if/"  onps_config

#change mgmt_ip_addr

read -p "enter mgmt_ip_addr: " mgmnt_ip
old_mgmnt_ip=`grep mgmt_ip_addr onps_config`

sed -i "s/$old_mgmnt_ip/mgmt_ip_addr=$mgmnt_ip/"  onps_config


#change mgmt_netmask

read -p "enter mgmt_netmask: " mgmt_netmask
old_mgmt_netmask=`grep mgmt_net_mask onps_config`

sed -i "s/$old_mgmt_netmask/mgmt_net_mask=$mgmt_netmask/"  onps_config

#change inter_net_if

read -p "enter inter_net_if: " inter_if
old_inter_if=`grep inter_net_if onps_config`

sed -i "s/$old_inter_if/inter_net_if=$inter_if/"  onps_config

#change virtiual_net_if

read -p "enter virtual_net_if: " virtual_if
old_virtual_if=`grep virtual_net_if onps_config`

sed -i "s/$old_virtual_if/virtual_net_if=$virtual_if/"  onps_config


#change public_net_if

read -p "enter public_net_if: " public_if
old_public_if=`grep public_net_if onps_config`

sed -i "s/$old_public_if/public_net_if=$public_if/"  onps_config



#change tunnel_ip_addr

read -p "enter tunnel_ip: " tunnel_ip
old_tunnel_ip=`grep  tunnel_ip= onps_config`

sed -i "s/$old_tunnel_ip/tunnel_ip=$tunnel_ip/"  onps_config


#change NTP server

read -p "enter NTP server name: " ntp_server
old_ntp_server=`grep ntp_server_name onps_config`

sed -i "s/$old_ntp_server/ntp_server_name=$ntp_server/"  onps_config


#change ONPS-HTTP-PROXY

read -p "enter ONPS-HTTP-PROXY: " HTTP_PROXY
old_HTTP_PROXY=`grep -w ONPS_HTTP_PROXY onps_config`

sed -i "s/$old_HTTP_PROXY/ONPS_HTTP_PROXY=$HTTP_PROXY/"  onps_config

#change ONPS-HTTP-PROXY_PORT

read -p "enter ONPS-HTTP-PROXY-PORT: " HTTP_PROXY_PORT
old_HTTP_PROXY_PORT=`grep -w ONPS_HTTP_PROXY_PORT onps_config`

sed -i "s/$old_HTTP_PROXY_PORT/ONPS_HTTP_PROXY_PORT=$HTTP_PROXY_PORT/"  onps_config

#change ONPS-HTTPS-PROXY

read -p "enter ONPS-HTTPS-PROXY: " HTTPS_PROXY
old_HTTPS_PROXY=`grep -w ONPS_HTTPS_PROXY onps_config`

sed -i "s/$old_HTTPS_PROXY/ONPS_HTTPS_PROXY=$HTTPS_PROXY/"  onps_config


#change ONPS-HTTPS-PROXY_PORT

read -p "enter ONPS-HTTPS-PROXY-PORT: " HTTPS_PROXY_PORT
old_HTTPS_PROXY_PORT=`grep -w ONPS_HTTPS_PROXY_PORT onps_config`

sed -i "s/$old_HTTPS_PROXY_PORT/ONPS_HTTPS_PROXY_PORT=$HTTPS_PROXY_PORT/"  onps_config



#change NO-PROXY

read -p "enter NO-PROXY: " NO_PROXY
old_NO_PROXY=`grep -w NO_PROXY onps_config`

sed -i "s/$old_NO_PROXY/NO_PROXY=$NO_PROXY/"  onps_config

#change NO_GIT-PROXY

read -p "enter NO_GIT-PROXY: " NO_GIT_PROXY
old_NO_GIT_PROXY=`grep -w NO_GIT_PROXY onps_config`

sed -i "s/$old_NO_GIT_PROXY/NO_GIT_PROXY=$NO_GIT_PROXY/"  onps_config


########################################################################
else
echo "------------------------------------------------------------ "
echo "you must answer \"y\" or \"n\".  Bye for now"
echo "------------------------------------------------------------ "
exit 1
##########################################################################
fi # end IF-1
##########################################################################

echo "------------------------------------------------------------ "
echo -e " Your onps_config file has been configured"
echo "------------------------------------------------------------ "
#echo -e "Now wait!!!  it is gonna run prepare_system.sh script" 
#echo -e "Thank you for using my service"
echo -e "Run /tf/stack-install-scripts/prepare_system.sh script"
echo "------------------------------------------------------------ "
sleep 3
#./prepare_system.sh

#init 6














