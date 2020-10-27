function install_packages (){

yum clean all

yum install net-tools vim screen git -y

}

function reboot_network () {

systemctl restart network






}



