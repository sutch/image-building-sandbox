# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = false  # false indicates that offline hosts be removed from hosts file

  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
    if vm.id
      `VBoxManage guestproperty get #{vm.id} "/VirtualBox/GuestInfo/Net/1/V4/IP"`.split()[1]
    end
  end

  config.vm.define "gitlab" do |node|
    node.vm.box = "gitlab"
    node.vm.box_url = "build/gitlab.virtualbox.box"
    node.vm.hostname = 'gitlab.test'
    node.vm.network "private_network", type: "dhcp"
    node.vm.provision :hostmanager
  end

end
