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

### Install PhpStorm 10 https://www.jetbrains.com/phpstorm/download/
# Licence server here - https://бэкдор.рф/phpstorm-7-8-9-10-product-key/
echo ${GREEN}............................. Installing and Configuring PHPStopm 10 ............................${RESET}
wget http://download-cf.jetbrains.com/webide/PhpStorm-10.0.3.tar.gz
tar -xvf PhpStorm-10.0.3.tar.gz
# IMPORTANT: For complete installation, you should execute two commands below from Terminal after finishing this script
#cd PhpStorm-*/bin/
#./phpstorm.sh || TRUE
echo ${GREEN}.............................................. Done .............................................${RESET}

