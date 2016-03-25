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
    exec ./upd-upg.sh
}
chrome() {
    exec ./chrome.sh
}
xclip() {
    exec ./xclip.sh
}
ccsm() {
    exec ./ccsm.sh
}
gparted() {
    exec ./gparted.sh
}
flashPlayer() {
    exec ./flash-player-ff.sh
}
tweakTool() {
    exec ./tweak-tool.sh
}
unrar() {
    exec ./unrar-7z.sh
}
skype() {
    exec ./skype.sh
}
torBrowser() {
    exec ./tor.sh
}
telegram() {
    exec ./telegram.sh
}
shutter() {
    exec ./shutter.sh
}
serverSsh() {
    exec ./ssh.sh
}
selenium() {
    exec ./selenium.sh
}
lemp() {
    exec ./lemp.sh
}
composer() {
    exec ./composer.sh
}
virtualBox() {
    exec ./virtual-box.sh
}
vagrant() {
    exec ./vagrant.sh
}
sublime() {
    exec ./sublime3.sh
}
phpStorm10() {
    exec ./php-storm10.sh
}
hipChat() {
    exec ./hip-chat.sh
}

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
