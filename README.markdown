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

See [[Preparing the host machine]](https://github.com/sutch/image-building-sandbox/wiki/Preparing-the-host-machine) for instructions on preparing the host machine.

Successfully tested environments
--------------------------------

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

The Build Process - A Walk-Through
----------------------------------

A virtual machine image can be built once the prerequisites have been installed.  This walk-through will provide the steps for building the gitlab image.

The process is to build a basic image containing the operating system, the vagrant user, Puppet and virtualization add-ons (in this case, VirtualBox Add-ons).  After this image is created, the basic image is used with Puppet to create an image to be used for a specific application.  The process is split this way to allow the basic image to be built once, saving time when building and testing new customizations, and to allow the second part of the process to be handled exclusively by Puppet in staging and production environments.

1. Clone the repository

   Execute the following command to clone the image-building-sandbox git repository from GitHub:
   ```bash
   git clone https://github.com/sutch/image-building-sandbox.git
   ```

1. Change working directory to image-building-sandbox

  Execute the following command:
  ```bash
  cd image-building-sandbox
  ```

1. Build the basic base image

   This step builds a basic Vagrant box and the OVF image containing Ubuntu Server 64-bit Linux, the vagrant user, Puppet, and VirtualBox Add-ons. The base image Vagrant box will be located in the build directory and will be located in the output-ubuntu-14.04.amd64.virtualbox directory as an OVF file.

   Execute the following command to build only the 64-bit image for VirtualBox:
   ```bash
   packer build -only=ubuntu-14.04.amd64.virtualbox ubuntu-14.04.json
   ```

   This step downloads the necessary ISO(s) into the packer_cache directory. Maintain any ISOs in this folder to negate the need to download during future builds.

   Note: To rebuild this basic image, remove the output folder output-ubuntu-14.04.amd64.virtualbox before executing the packer build command.

1. Rename the OVF file to remove the timestamp

   To allow the OVF image to be used by other Packer templates, copy (or rename) the OVF file to a filename not containing the timestamp.

   Mac OS X and Linux-- execute the following command to copy the OVF file:
   ```bash
   cp output-ubuntu-14.04.amd64.virtualbox/packer-ubuntu-14.04.amd64.virtualbox-*.ovf output-ubuntu-14.04.amd64.virtualbox/packer-ubuntu-14.04.amd64.virtualbox.ovf
   ```

   ### Microsoft Windows 7 Workaround

   VirtualBox on Microsoft Windows 7 appears to have challenges when renaming OVF files.  Instead update the gitlab.json file to refer to the OVF file containing the timestamp.

1. Download and install the Puppet manifests needed for GitLab from Puppet Forge (installs to .puppet in the current directory)

   ```bash
   puppet module install --target-dir .puppet spuder-gitlab
   puppet module install --target-dir .puppet puppetlabs-ruby
   puppet module install --target-dir .puppet jfryman/nginx
   puppet module install --target-dir .puppet fsalum-redis
   puppet module install --target-dir .puppet puppetlabs-postgresql
   ```

1. Build the GitLab image

   Note:  The following will fail if image-building-sandbox is not located in your home directory. The gitlab.json file refers to .puppet/modules/ as the location for installed Puppet modules. Change the module_paths value in gitlab.json if this is not the relative path to the folder.

   Execute the following command to build the image:
   ```bash
   packer build gitlab.json
   ```

   Note:  The following two warning messages are expected:
     * Warning: Setting templatedir is deprecated. See http://links.puppetlabs.com/env-settings-deprecations
     * Warning: Config file /etc/puppet/hiera.yaml not found, using Hiera defaults


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
