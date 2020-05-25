# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_MEM = "512"
BOX_CPU = 1
BOX_NAME =  "debian/buster64"

ANSIBLE_PLAYBOOK  = "site.yml"

$script = <<SCRIPT
apt-get update
apt-get upgrade
apt-get install net-tools
SCRIPT

Vagrant.configure("2") do |config|

  config.vm.define "vault1" do |vault1|
    vault1.vm.box = BOX_NAME
    vault1.vm.hostname = "vault1.local"
    vault1.vm.network "public_network"
    vault1.vm.provider "virtualbox" do |v|
      v.name = "vault1"
      v.memory = BOX_MEM
      v.cpus = BOX_CPU
    end
    vault1.vm.provision "shell", inline: $script
  end

  config.vm.define "vault2" do |vault2|
    vault2.vm.box = BOX_NAME
    vault2.vm.hostname = "vault2.local"
    vault2.vm.network "public_network"
    vault2.vm.provider "virtualbox" do |v|
      v.name = "vault2"
      v.memory = BOX_MEM
      v.cpus = BOX_CPU
    end
    vault2.vm.provision "shell", inline: $script
  end

  config.vm.define "vault3" do |vault3|
    vault3.vm.box = BOX_NAME
    vault3.vm.hostname = "vault3.local"
    vault3.vm.network "public_network"
    vault3.vm.provider "virtualbox" do |v|
      v.name = "vault3"
      v.memory = BOX_MEM
      v.cpus = BOX_CPU
    end
    vault3.vm.provision "shell", inline: $script
  end


  config.vm.provision :ansible do |ansible|
    ansible.playbook = ANSIBLE_PLAYBOOK
    ansible.verbose = true
    ansible.extra_vars = {
      VAULT_LOG_LEVEL: "info",
      VAULT_IFACE: "eth1"
    }
    ansible.groups = {
      "vault_raft_servers" => ["vault[1:3]"]
    }

    ansible.host_vars = {
      "vault1" => {},
      "vault2" => {},
      "vault3" => {}
    }
  end

end


