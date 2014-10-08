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

See the wiki for detailed instructions on how to install VirtualBox, Packer, Puppet and Facter, Vagrant and Vagrant Host Manager.

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
  * Windows 7 Professional, Service Pack 1 (tested on 10/8/2014)
    * VirtualBox test build r96191 (4.3.17) [https://www.virtualbox.org/download/testcase/VirtualBox-4.3.17-96191-Win.exe] -- note that several earlier builds fail to start virtual machines on this version of windows
    * Packer 0.7.1 (amd64)
    * Puppet 3.7.1-x64 (includes Facter 2.2.0)
    * Vagrant 1.6.5
    * Vagrant Host Manager 1.5.0

Documentation
-------------

See the [wiki](https://github.com/sutch/image-building-sandbox/wiki) for documentation.

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
  1. Create your feature branch (`git checkout -b my-new-feature`)
  1. Commit your changes (`git commit -am 'Add some feature'`)
  1. Push to the branch (`git push origin my-new-feature`)
  1. Create new Pull Request
