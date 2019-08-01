# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

SUBNET="10.10.10"
DOMAIN="vm.local"

MASTERNAME="ether-node"
MASTERIP="#{SUBNET}.5"

CPUS=1
MEMORY=2048

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--cpus", "#{CPUS}"]
    v.customize ["modifyvm", :id, "--memory", "#{MEMORY}"]
  end
  config.vm.hostname = "#{MASTERNAME}.#{DOMAIN}"
  config.vm.network :private_network, ip: "#{MASTERIP}" 
  config.vm.network "forwarded_port", guest: 8080, host: 19090
  config.vm.network "forwarded_port", guest: 5601, host: 15601
  config.vm.synced_folder "/data/vagrant_data", "/data"
  ####### Install Puppet Agent #######
  config.vm.provision "shell", path: "bootstrap.sh"
#  config.vm.provision "shell", path: "copy_config.sh"
  config.vm.provision "shell", path: "install-puppet-modules.sh"
  ####### Provision #######
  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "./site"
#    puppet.options = "--verbose --debug"
  end
end

