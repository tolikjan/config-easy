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

### Install Selenium Server http://www.seleniumhq.org/
echo ${GREEN}.................................. Installing Selenium Server ...................................${RESET}
echo -ne '\n' | add-apt-repository ppa:webupd8team/java
apt-get update
# Create folder for Selenium
mkdir ~/selenium
cd ~/selenium
# Install xvfb - display server which implementing the X11 display server protocol
apt-get install xvfb -y
# Get Selenium and install headless Java runtime (you should check newest release on http://www.seleniumhq.org/download/)
wget http://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.0.jar
apt-get install openjdk-7-jre-headless -y
# Install headless GUI for firefox. Xvfb is a display server that performs graphical operations in memory
#apt-get install xvfb -y
# Starting up Selenium server
#DISPLAY=:1 xvfb-run java -jar ~/selenium/selenium-server-standalone-2.53.0.jar
# Get latest Chrome Driver variable from LATEST_RELEASE file
wget -N http://chromedriver.storage.googleapis.com/LATEST_RELEASE
cat LATEST_RELEASE | while read LINE
do
 wget -N http://chromedriver.storage.googleapis.com/${LINE}/chromedriver_linux64.zip
 unzip chromedriver_linux64.zip
 rm -rf chromedriver_linux64.zip
 rm LATEST_RELEASE
done
chmod 777 -R ~/selenium/
cd
echo ${GREEN}.............................................. Done .............................................${RESET}
