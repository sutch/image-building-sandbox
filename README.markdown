image-building-sandbox
======================

Overview
--------

This repository is used for learning about the building of machine images.

The intent is to build a solution to define machine images in a set of configuration files so that images can be consistently built to run on a variety of platforms.

Has options to:
  1. build Ubuntu 14.04 Server for 64- and 32-bit architectures
  2. build for VirtualBox and VMWare

Builds:
  1. basic image, containing operating system, vagrant user, Puppet, and VirtualBox or VMWare additions
  2. basic image plus Apache HTTP server


Prerequistites
--------------

  1. internet connectivity -- to obtain ISOs and system updates
  2. VirtualBox -- to build (and run) images
  3. Packer -- to manage the building of images
  4. Vagrant -- to manage images (boxes)
  5. Git client
  6. SSH client
  7. text editor

### Download and install VirtualBox

See https://www.virtualbox.org/wiki/Downloads

### Download and install Packer

For Mac OS X, Brew does not contain the latest version. Use the following instructions.

  1. download from http://www.packer.io/downloads.html
  2. extract to the /usr/local/packer directory
  3. update ~/.profile to include the line
```
export PATH=$PATH:/usr/local/packer
```
  4. execute the following command to source the .profile file to to effect for the current session
```
. ~/.bash_profile
```

### Download and install Puppet and Facter

See http://puppetlabs.com/misc/download-options

### Download and install Vagrant

See https://www.vagrantup.com/downloads.html

Successfully tested environments
--------------------------------

  * OS X 10.9.4
    * VirtualBox 4.3.16
    * Packer 0.7.1
    * Puppet 3.7.1
    * Vagrant 1.6.5
  * Windows 7
    * [TBD]

The Process
-----------

### Build basic image 

The basic image contains very little customization.  We break up the process so that this long running build can be done once and the build involving Puppet can be modified and tested fairly quickly.

Execute the following command to build only the 64-bit image for VirtualBox:
```
packer build -only=ubuntu-14.04.amd64.virtualbox ubuntu-14.04.json
```

To iterate, remove the output folder output-ubuntu-14.04.amd64.virtualbox before building again.

### Build image with Apache

After the above is complete, update ubuntu-14.04-apache.json to correct source_path for the timestamped OVF file and then execute the following: 

```
packer build ubuntu-14.04-apache.json
```

To iterate, remove the output folder output-ubuntu-14.04.amd64.apache.virtualbox before building again.

### Run basic image containing Apache

To import the basic box containing Apache:
```
vagrant init ubuntu-14.04-apache build/ubuntu-14.04.amd64.apache.virtualbox.box
```

Have VirtualBox display VM console by updating Vagrantfile with:
```
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
  end
```

Run the machine image:
```
vagrant up
```

To halt the image:
```
vagrant halt
```

To destroy the image:
```
vagrant destroy
```

To remove the box in order to import a newly built image:
```
vagrant box remove ubuntu-14.04-apache
```

Other notes
-----------

Install Puppet module for Apache from Puppet Forge (to HOME/puppet):
```
puppet module install puppetlabs-apache
```
