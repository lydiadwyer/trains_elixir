# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

VM_NAME = "trains_elixir"
MEMORY_SIZE_MB = "1024"
NUMBER_OF_CPUS = 1

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    #changing to ubuntu 14.04
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v, override|
      v.name = VM_NAME
      v.cpus = NUMBER_OF_CPUS
      v.gui = false
      v.memory = MEMORY_SIZE_MB

      override.vm.synced_folder "./provision", "/vagrant"
      override.vm.synced_folder "./data/web", "/var/www/trains_elixir"
      # v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/www", "1"]
      # http://perrymitchell.net/article/npm-symlinks-through-vagrant-windows/
        
        
        
      #dont need to make a private network unless you are doing more than one box
      #elixir_box.vm.network :private_network, ip: "192.168.55.55"
      # accessing "localhost:8080" will access port 80 on the guest machine.
      override.vm.network "forwarded_port", guest: 5432, host: 5432 # postgres
      override.vm.network "forwarded_port", guest: 4000, host: 4000 # phoenix
      override.vm.network "forwarded_port", guest: 80, host: 8080 # phoenix if you want nginx
      override.vm.network "forwarded_port", guest: 9999, host: 9999 #testing
    end
    
    # Configure Vagrant Cachier
    if Vagrant.has_plugin?("vagrant-cachier")
        config.cache.scope = :box

    end

    config.vm.provision :shell, path: "./provision/vagrant_provision.sh"
end
