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

### Install SublimeText 3 https://www.sublimetext.com/3
# Just uncomment lines below between "—– BEGIN LICENSE —–" and "—— END LICENSE —"
# or use some code from this gist — https://gist.github.com/wayou/3a2d7c1576340f1d3ac8
###
#—– BEGIN LICENSE —–
#Michael Barnes
#Single User License
#EA7E-821385
#8A353C41 872A0D5C DF9B2950 AFF6F667
#C458EA6D 8EA3C286 98D1D650 131A97AB
#AA919AEC EF20E143 B361B1E7 4C8B7F04
#B085E65E 2F5F5360 8489D422 FB8FC1AA
#93F6323C FD7F7544 3F39C318 D95E6480
#FCCC7561 8A4A1741 68FA4223 ADCEDE07
#200C25BE DBBC4855 C4CFB774 C5EC138C
#0FEC1CEF D9DCECEC D3A5DAD1 01316C36
#—— END LICENSE —
echo ${GREEN}.................................... Installing SublimeText 3 ...................................${RESET}
echo -ne '\n' | add-apt-repository ppa:webupd8team/sublime-text-3
apt-get update
apt-get install sublime-text-installer -y
echo ${GREEN}.............................................. Done .............................................${RESET}
