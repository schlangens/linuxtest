# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "minimal/centos7"
  config.vm.hostname = "centos7"
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.enable :yum
  end
  config.vm.boot_timeout = 600
  #config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
  config.vm.provision "shell", path: "provision.sh"
  
  # Configure network settings
  config.vm.network "private_network", ip: "192.168.50.1"
  # config.vm.network "public_network"

  config.vm.provider "virtualbox" do |vb|
  # Display the VirtualBox GUI when booting the machine
  #  vb.gui = true

  # Customize the amount of memory or cpus on the VM:
    vb.memory = "1024"
    vb.cpus = "2"
  end
end
