# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "phusion/ubuntu-14.04-amd64"
  config.vm.provision "shell", path: 'provision.sh'
  config.vm.network "private_network", ip: "192.168.50.4"
end
