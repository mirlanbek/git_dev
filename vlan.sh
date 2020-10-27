#!/bin/bash

net1=ens786f1
net2=ens786f2
net3=ens786f3
net4=ens786f4
net5=ens786f5
net6=ens786f6
net7=ens786f7
net8=ens786f8
#net9=ens786f9
#net10=ens786f10
#net11=ens786f11
#net12=ens786f12
#net13=ens786f13
#net14=ens786f14
#net15=ens786f15
#net16=ens786f16
#net17=ens786f17
vlan_ranges=(0 1000:1100 1101:1200 1201:1300 1301:1400 1401:1500 1501:1600 1601:1700 1701:1800)


count_if=`grep ^net[0-9]*= vlan.sh| wc -l`

f_vlan (){
	for i in `seq $count_if`
	do
	eval "temp_vlan=\${vlan_ranges[$i]}"

	printf "%s," "physnet$i:$temp_vlan"
	done
	printf "\n"
}

f_br (){
	for k in `seq $count_if`
	do
	eval "temp_br=\$net$k"
	printf "%s," "physnet$k:br-$temp_br"
	done
	printf "\n"
}
f_phys_network () {
	for j in `seq $count_if`
	do
	printf "%s," physnet$j
	done
	printf "\n"
}

f_br
f_vlan
f_phys_network

sed -i 's/ML2_VLAN_RANGES=physnet1:1000:1010/ML2_VLAN_RANGES='$(f_vlan)'/g' local.conf


sed -i '/OVS_BRIDGE_MAPPINGS/a \OVS_DPDK_PORT_MAPPING='$(f_br)'' local.conf
sed -i 's/PHYSICAL_NETWORK=physnet1/PHYSICAL_NETWORK='$(f_phys_network)'/g' local.conf
 




