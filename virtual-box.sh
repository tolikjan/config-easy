#!/bin/bash

# This script will be helpful after reinstalling you operating system
# Tested on Ubuntu 14.04.4 64x

# For testing I used vagrant-box
# https://sourceforge.net/projects/osboxes/files/vms/vbox/Ubuntu/14.04/14.04.4/Ubuntu_14.04.4-64bit.7z/download
ROOT_PASS="osboxes.org"

# Type your own password below which should be correct for you system
#ROOT_PASS=""
# coloured variables
RESET=`tput sgr0`
GREEN=`tput setaf 2`

### Install VirtualBox https://www.virtualbox.org/
echo ${GREEN}.................................... Installing VirtualBox  .....................................${RESET}
# IMPORTANT! Before using VirtualBox, make sure that virtualization is enabled in your BIOS settings
# IMPORTANT! Make sure that VirtualBox not running right now
# Uninstall VirtualBox if it was installed previously
apt-get purge "^virtualbox-.*" -y
apt-get update
# Clean up
apt-get autoremove -y | apt-get autoclean - y | apt-get clean -y
# add the official Virtualbox repository for Linux
sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" >> /etc/apt/sources.list.d/virtualbox.list'
# Now, download and register the ORACLE public key
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
# Update and install Virtualbox
apt-get update
apt-get install dkms virtualbox-5.0 -y
# Install Extension Pack for VirtualBox
# You can check latest extension pack version here - https://www.virtualbox.org/wiki/Downloads
EXT_PACK="Oracle_VM_VirtualBox_Extension_Pack-5.0.16.vbox-extpack"
wget http://download.virtualbox.org/virtualbox/5.0.16/${EXT_PACK}
echo ${ROOT_PASS} | VBoxManage extpack install ${EXT_PACK}
rm -rf ${EXT_PACK}
rm -rf virtualbox*.deb
echo ${GREEN}.............................................. Done .............................................${RESET}

