# ------------------------ vitualization --------------

#from epel:
yum install msr-tools -y
rdmsr 0x3a

#if output 3 or 5  means virtualization enabled
# -------------- New scripting ------------------------------------------------

if [[ $1 == *","* ]]; then
    IFS=',' read -r -a srcs <<< "$1"
    if [[ ${#srcs[@]} -lt 2 ]]; then
        echo "Number of sources read in as list: ${#srcs[@]}
              Need at least two values to take a csv list as
              argument. Error fatal: exiting."
        exit 1
    fi
else
    srcs="$1"
fi

for src in ${srcs[@]}; do
    if [ $("$getent_path" group "$src") ] ; then
        src_str=$("$getent_path" group "$src" | cut -d ':' -f 4)
        IFS=',' read -r -a src_usrs <<< $src_str
        for usr in ${src_usrs[@]}; do
            "$usermod_path" -a -G  "$dest" "$usr"
        done
    else
        echo "Source group $src does not exist.
              Trying next group."
    fi
done


# -----------------------------------------------------------------------------------------

docker save openvino | gzip > openvino.tar.gz


# ------------------------- Samba ----------------------------------------------------------
# pdbedit -L ; smbpasswd -a root ; systemctl start nmb smb;


[linux]
path=/root/samba
write list = root

# ---------------------------- Vagrantfile-virtualbox--------------------------------------------

# -*- mode: ruby -*-
# vi: set ft=ruby :

$vm_number = 3

Vagrant.configure("2") do |config|
    config.vm.box = "generic/ubuntu1804"
    config.vm.network :public_network,
      :dev => "virbr0",
      :mode => "bridge",
      :type => "bridge"

    config.vm.provider :virtualbox do |virtualbox|
    end

    (0..$vm_number-1).each do |i|
        config.vm.define vm_name = "server%d" % i do |vsmc|

            vsmc.vm.hostname = vm_name

            vsmc.vm.provider :virtualbox do |domain|
              domain.memory = 2048
              domain.cpus = 2
            end
        end
    end
end

# ------------------------ Vagrantfile libvirt --------------------------------------------------

# Note: if cannot restart start libvirt-bin, no probs, just install virt-manager and vagrant up.

# -*- mode: ruby -*-
# vi: set ft=ruby :

$vm_number = 2

Vagrant.configure("2") do |config|
    config.vm.box = "generic/ubuntu1804"
    config.vm.network :public_network,
      :dev => "virbr0",
      :mode => "bridge",
      :type => "bridge"

    config.vm.provider :libvirt do |libvirt|
        libvirt.driver = "kvm"
        libvirt.username = "root"
        libvirt.storage_pool_name = "default"
    end

    (0..$vm_number-1).each do |i|
        config.vm.define vm_name = "vsmc%d" % i do |vsmc|
            vsmc.vm.hostname = vm_name

            vsmc.vm.provider :libvirt do |domain|
              domain.memory = 1028
              domain.cpus = 1
            end
        end
    end
end

#---------------------------------------------------------------
