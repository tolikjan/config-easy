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


### Functions
updUpg() {
    exec sudo sh upd-upg.sh
}
chrome() {
    exec sudo sh chrome.sh
}
xclip() {
    exec sudo sh xclip.sh
}
ccsm() {
    exec sudo sh ccsm.sh
}
gparted() {
    exec sudo sh gparted.sh
}
flashPlayer() {
    exec sudo sh flash-player-ff.sh
}
tweakTool() {
    exec sudo sh tweak-tool.sh
}
unrar() {
    exec sudo sh unrar-7z.sh
}
skype() {
    exec sudo sh skype.sh
}
torBrowser() {
    exec sudo sh tor.sh
}
telegram() {
    exec sudo sh telegram.sh
}
shutter() {
    exec sudo sh shutter.sh
}
serverSsh() {
    exec sudo sh ssh.sh
}
selenium() {
    exec sudo sh selenium.sh
}
lemp() {
    exec sudo sh lemp.sh
}
composer() {
    exec sudo sh composer.sh
}
virtualBox() {
    exec sudo sh virtual-box.sh
}
vagrant() {
    exec sudo sh vagrant.sh
}
sublime() {
    exec sudo sh sublime3.sh
}
phpStorm10() {
    exec sudo sh php-storm10.sh
}
hipChat() {
    exec sudo sh hip-chat.sh
}

# List of tools where your can choose all preferred programs
dialog --title "Config Ubuntu Script" --checklist "Use <Space> to choose tools which you want to install:" 30 58 23 \
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
		UpdateUpgrade)updUpg
		;;
		GoogleChrome)chrome
		;;
		xclip)xclip
		;;
		CCSM)ccsm
		;;
		Gparted)gparted
		;;
		FireFoxFlashPlayer)flashPlayer
		;;
		TweakTool)tweakTool
		;;
		7zandUnrar)unrar
		;;
		Skype)skype
		;;
		TorBrowser)torBrowser
		;;
		Telegram)telegram
		;;
		Shutter)shutter
		;;
		SSHServer)serverSsh
		;;
		SeleniumServer)selenium
		;;
		LEMP)lemp
		;;
		Composer)composer
		;;
		VirtualBox)virtualBox
		;;
		Vagrant)vagrant
		;;
		SublimeText3)sublime
		;;
		PHPStorm10)phpStorm10
		;;
		HipChat)hipChat
		;;
		*)
		;;
	esac
done < results
