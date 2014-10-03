image-building-sandbox
======================

Overview
--------

This repository is used for learning about the building of machine images.

The intent is to build a solution to define machine images in a set of configuration files so that images can be consistently built to run on a variety of platforms.

Has options to:
  1. build Ubuntu 14.04 Server for 64- and 32-bit architectures
  1. build for VirtualBox and VMWare

Currently, image-building-sandbox builds:
  1. basic image, containing operating system, vagrant user, Puppet, and VirtualBox or VMWare additions
  1. basic image with GitLab

Prerequistites
--------------

The host machine requires:
1. internet connectivity
1. VirtualBox
1. Packer
1. Puppet and Facter
1. Vagrant 
1. Vagrant Host Manager plugin
1. Git client
1. SSH client
1. text editor

See [Preparing the host machine](https://github.com/sutch/image-building-sandbox/wiki/Preparing-the-host-machine) for instructions on preparing the host machine.

See [The Build Process: A Sample Walk Through](/sutch/image-building-sandbox/wiki/The-Build-Process:-A-Sample-Walk-Through) for a description of the steps in building a virtual machine image.

Successfully tested environments
--------------------------------

Note: These were tested against previous versions.

  * OS X 10.9.5
    * VirtualBox 4.3.16
    * Packer 0.7.1
    * Puppet 3.7.1
    * Facter 2.2.0
    * Vagrant 1.6.5
    * Vagrant Host Manager 1.5.0
  * Windows 7 Professional, Service Pack 1
    * VirtualBox test build r96191 (4.3.17) [https://www.virtualbox.org/download/testcase/VirtualBox-4.3.17-96191-Win.exe] -- note that several earlier builds fail to start virtual machines on this version of windows
    * Packer 0.7.1 (amd64)
    * Puppet 3.7.1-x64 (includes Facter 2.2.0)
    * Vagrant 1.6.5
    * Vagrant Host Manager 1.5.0

Using the Virtual Machine Image
-------------------------------

Described are common tasks for running the gitlab virtual machine image.

### Run the virtual machine

```bash
vagrant up gitlab
```

### SSH to virtual machine

```bash
vagrant ssh
```

This will create an SSH session to the virtual machine.

### List contents of shared folder (from guest OS)

```bash
ls /vagrant
```

### Apply Puppet manifests locally

The host machines image-building-sandbox directory is available to the virtual machine as the /vagrant directory. This allows us to apply Puppet manifests locally by executing the following command.

```bash
sudo puppet apply /vagrant/puppet/gitlab.pp --modulepath /vagrant/.puppet
```

### Open GitLab in browser from host machine

Browse to http://gitlab.localhost/

### Halt the virtual machine

```bash
vagrant halt gitlab
```

### Destroy the VirtualBox image

```bash
vagrant destroy
```

### Remove the Vagrant image

```bash
vagrant box remove gitlab
```

### Update the hosts file after shutting down a VM

Useful when system (Windows) fails to correctly update the hosts file after 'vagrant up'.  Check /etc/hosts or C:\Windows\System32\drivers\etc\hosts for appropriate IP address / hostname pair.

```bash
vagrant hostmanager
```
- or, for example -
```bash
vagrant hostmanger gitlab
```

Todo
----

  * Resolve Packer message: Warning: Config file /etc/puppet/hiera.yaml not found, using Hiera defaults
  * Cache apt-get updates.
  * Control for versions of modules installed from Puppet Forge (error occurred when update to GitLab module broke build--fixed by changing verson of GitLab specified in gitlab.pp)
    * To list modules and versions, execute: `puppet module list --modulepath .puppet`
    * Command line option (for `puppet module install`) to specify module version to install: `--version VER`
    * To update module, execute: `puppet module upgrade --modulepath .puppet NAME`

References
----------

  * [Oracle VM VirtualBox User Manual](https://www.virtualbox.org/manual/UserManual.html)
  * [Packer Documentation](http://www.packer.io/docs)
  * [Puppet Labs Documentation](https://docs.puppetlabs.com/)
  * [Vagrant Documentation](https://docs.vagrantup.com/v2/)
  * [Vagrant Host Manager](https://github.com/smdahlen/vagrant-hostmanager) plugin

### Windows specific
  * [Git for Windows](http://msysgit.github.io/) (install using default options)

Contributing
------------

  1. Fork it
  1. Create your feature branch (git checkout -b my-new-feature)
  1. Commit your changes (git commit -am 'Add some feature')
  1. Push to the branch (git push origin my-new-feature)
  1. Create new Pull Request
