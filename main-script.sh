#!/bin/bash

# This script will be helpful after reinstalling you operating system
# Tested on Ubuntu 14.04.4 64x
#
# For testing I used vagrant-box
# https://sourceforge.net/projects/osboxes/files/vms/vbox/Ubuntu/14.04/14.04.4/Ubuntu_14.04.4-64bit.7z/download
ROOT_PASS="osboxes.org"
#
# Type your own password below which should be correct for you system
#ROOT_PASS=""
# coloured variables
RESET=`tput sgr0`
GREEN=`tput setaf 2`

# List of tools where your can choose all preferred programs
whiptail --title "Config Ubuntu Script" --checklist --separate-output "Use <Space> to choose tools which you want to install:" 30 58 23 \
"UpdateUpgrade" "" on \
"GoogleChrome" "" on \
"xclip" "" off \
"CCSM" "" off \
"Gparted" "" off \
"FireFoxFlashPlayer" "" on \
"TweakTool" "" off \
"7zandUnrar" "" on \
"Skype" "" on \
"TorBrowser" "" on \
"Telegram" "" on \
"Shutter" "" on \
"SSHServer" "" on \
"SeleniumServer" "" on \
"LEMP" "" on \
"Composer" "" on \
"VirtualBox" "" on \
"Vagrant" "" on \
"SublimeText3" "" on \
"PHPStopm10" "" on \
"HipChat" "" on 2>results

while read CHOICE
do
	case $CHOICE in
		UpdateUpgrade)exec upd-upg.sh
		;;
		GoogleChrome)exec chrome.sh
		;;
		xclip)exec xclip.sh
		;;
		CCSM)exec ccsm.sh
		;;
		Gparted)exec gparted.sh
		;;
		FireFoxFlashPlayer)exec flash-player-ff.sh
		;;
		TweakTool)exec tweak-tool.sh
		;;
		7zandUnrar)exec unrar-7z.sh
		;;
		Skype)exec skype.sh
		;;
		TorBrowser)exec tor.sh
		;;
		Telegram)exec telegram.sh
		;;
		Shutter)exec shutter.sh
		;;
		SSHServer)exec ssh.sh
		;;
		SeleniumServer)exec selenium.sh
		;;
		LEMP)exec lemp.sh
		;;
		Composer)exec composer.sh
		;;
		VirtualBox)exec virtual-box.sh
		;;
		Vagrant)exec vagrant.sh
		;;
		SublimeText3)exec sublime3.sh
		;;
		PHPStorm10)exec php-storm10.sh
		;;
		HipChat)exec hip-chat.sh
		;;
		*)
		;;
	esac
done < results
