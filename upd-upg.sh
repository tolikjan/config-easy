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

### Update & Upgrade system
echo ${GREEN}................................. Update and Upgrade the system .................................${RESET}
apt-get update && apt-get upgrade -y
# Disable guest session
echo "allow-guest=false" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
# configure system to allow more performance
# "vm.swappiness=10" — means that you system will use swap when you RAM will be full for 90%
echo "vm.swappiness=10" >> /etc/sysctl.conf
echo ${GREEN}.............................................. Done .............................................${RESET}

