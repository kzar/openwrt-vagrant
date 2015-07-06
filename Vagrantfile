# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "openwrt" do |config|
    config.vm.box = "ARTACK/debian-jessie"

    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    config.vm.provision :shell, :inline => "
      sudo apt-get update && apt-get install --yes puppet
      puppet module install puppetlabs-vcsrepo
    "
    config.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path = "modules"
      puppet.manifest_file = "openwrt.pp"
    end

    config.vm.provision :shell, :inline => "
      cd /home/vagrant/openwrt
      sudo chown vagrant:vagrant ./* -R
    "
  end
end
