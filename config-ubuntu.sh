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
### Update & Upgrade system
sleep 5
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}................................. Update and Upgrade the system .................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
apt-get update && apt-get upgrade -y
# disable guest session
echo "allow-guest=false" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
# configure system to allow more performance
# "vm.swappiness=10" — means that you system will use swap when you RAM will be full for 90%
echo "vm.swappiness=10" >> /etc/sysctl.conf
}
chrome() {
### Install Google Chrome https://www.google.com/chrome/
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}................................... Installing Google Chrome ....................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
# Get deb, unpack it and remove after installing
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i ./google-chrome*.deb
apt-get install -f -y
rm -rf google-chrome*.deb
}
xclip() {
### Install xclip (for copy files via terminal)
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}........................................ Installing xclip .......................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
apt-get install xclip -y
# Example for copy the contents of the id_rsa.pub file to your clipboard with command below
#xclip -sel clip < ~/.ssh/id_rsa.pub
}
ccsm() {
### Install ccsm http://wiki.compiz.org/CCSM http://help.ubuntu.ru/wiki/ccsm
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}........................................ Installing ccsm ........................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
apt-get install compizconfig-settings-manager -y
}
gparted() {
### Install gparted http://gparted.org/
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}...................................... Installing gparted .......................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
apt-get install gparted -y
}
flashPlayer() {
### Install Flash player for Firefox
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}............................... Installing Firefox Flash Player .................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
apt-get install flashplugin-installer -y
}
tweakTool() {
### Install Tweak Tools for Ubuntu additional settings
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}.................................... Installing Tweak Tool ......................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
apt-get install unity-tweak-tool
}
unrar() {
### Install utilities for archive manager with 7z and rar support
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}.................................... Installing 7z and Unrar ....................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
apt-get install p7zip-full -y
apt-get install unrar -y
}
skype() {
### Install Skype http://www.skype.com/
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}........................................ Installing Skype .......................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
# Install dependencies for Skype
apt-get install -y sni-qt:i386 libdbusmenu-qt2:i386 libqt4-dbus:i386 libxss1:i386
apt-get install -y libgtk2.0-0:i386 gtk2-engines:i386 libgconf-2-4:i386
add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
# Install Skype
apt-get update
apt-get install skype -y
# Install sound plugins for fixing problems with sound for Ubuntu
apt-get install libasound2-plugins:i386 -y
}
torBrowser() {
### Install Tor Browser https://www.torproject.org/
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}.................................... Installing Tor Browser .....................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
echo -ne '\n' | add-apt-repository ppa:webupd8team/tor-browser
apt-get update
apt-get install tor-browser -y
}
telegram() {
### Install Telegram messenger https://telegram.org/
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}...................................... Installing Telegram ......................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
echo -ne '\n' | add-apt-repository ppa:atareao/telegram
apt-get update
apt-get install telegram -y
}
shutter() {
### Install Shutter http://shutter-project.org/
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}...................................... Installing Shutter .......................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
echo -ne '\n' | add-apt-repository ppa:shutter/ppa
apt-get install shutter -y
}
serverSsh() {
### Install SSH
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}..................................... Installing SSH Server .....................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
apt-get update
apt-get install openssh-client -y
apt-get install openssh-server -y
mkdir ~/.ssh
chmod 777 -R ~/.ssh/
}
git() {
### Install Git
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}......................................... Installing Git ........................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
apt-get update
apt-get install git -y
apt-get install tig -y
}
composer() {
### Install Composer
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}...................................... Installing Composer ......................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
apt-get update
apt-get install php5-curl -y
apt-get install curl php5-cli git -y
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
chmod 777 -R ~/.composer/
}
codesniffer() {
### Install Codesniffer
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}.................................... Installing Codesniffer .....................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
### Install code sniffer for phpStorm
# https://www.drupal.org/node/1419988
# TODO: Check the code sniffer installation
composer global require drupal/coder
composer global update drupal/coder --prefer-source
export PATH="$PATH:$HOME/.composer/vendor/bin"
phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer
}
selenium() {
### Install Selenium Server http://www.seleniumhq.org/
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}.................................. Installing Selenium Server ...................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
echo -ne '\n' | add-apt-repository ppa:webupd8team/java
apt-get update
# Create folder for Selenium
mkdir ~/selenium
cd ~/selenium
# Install xvfb - display server which implementing the X11 display server protocol
apt-get install xvfb -y
# Get Selenium and install headless Java runtime (you should check newest release on http://www.seleniumhq.org/download/)
wget http://selenium-release.storage.googleapis.com/2.52/selenium-server-standalone-2.52.0.jar
apt-get install openjdk-7-jre-headless -y
# Install headless GUI for firefox. Xvfb is a display server that performs graphical operations in memory
#apt-get install xvfb -y
# Starting up Selenium server
#DISPLAY=:1 xvfb-run java -jar ~/selenium/selenium-server-standalone-2.52.0.jar
# Get latest Chrome Driver variable from LATEST_RELEASE file
wget -N http://chromedriver.storage.googleapis.com/LATEST_RELEASE
cat LATEST_RELEASE | while read line
do
 wget -N http://chromedriver.storage.googleapis.com/${line}/chromedriver_linux64.zip
 unzip chromedriver_linux64.zip
 rm -rf chromedriver_linux64.zip
 rm LATEST_RELEASE
done
chmod 777 -R ~/selenium/
cd
}
lemp() {
### Install LEMP (nginx + MySQL + PHPMyAdmin) and configure it
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}.............. Installing and Configuring LEMP: Linux + nginx + MySQL + phpmyadmin ..............${RESET}
echo ${GREEN}.................................................................................................${RESET}
# Uninstall/Clear possible extra programs
apt-get purge -y apache2* php5* mysql*
dpkg -l | grep apache*
dpkg -l | grep php5*
dpkg -l | grep mysql*
# Set up variables
# site folder path
SITE_PATH="/usr/share/nginx/html"
SERVER_NAME="local.com"
# www config
WWW_CONF="/etc/php5/fpm/pool.d/www.conf"
# nginx config
NGINX_CONF="/etc/nginx/nginx.conf"
# default nginx config
DEFAULT_NGINX_CONF="/etc/nginx/sites-available/default"
DEFAULT_NGINX_CONF_LINK="/etc/nginx/sites-enabled/default"
# mysql variables
MYSQL_ROOT_USER="root"
MYSQL_ROOT_PASS="root"
### Install PHP
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}.......................................... Installing PHP .......................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
echo -ne '\n' | add-apt-repository ppa:ondrej/php5-5.6
apt-get update && apt-get upgrade -y
apt-get install php5 -y
apt-get install php5-fpm php5-mysql php5-cli php5-curl php5-gd php5-mcrypt php5-xdebug -y
# php.ini error reporting configuring
for INI in $(find /etc -name 'php.ini')
do
    sed -i 's/^error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/' ${INI}
    sed -i 's/^display_errors = Off/display_errors = On/' ${INI}
    sed -i 's/^display_startup_errors = Off/display_startup_errors = On/' ${INI}
    sed -i 's/^html_errors = Off/html_errors = On/' ${INI}
    sed -i 's/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' ${INI}
    # Change configuration if you planing to load big files
    sed -i 's/^post_max_size = 8M/post_max_size = 200M/' ${INI}
    sed -i 's/^upload_max_filesize = 2M/upload_max_filesize = 200M/' ${INI}
done
# Set up xdebug variable
XDEBUG="$(find / -name "xdebug.so" 2> /dev/null)"
sleep 10
for INI in $(find /etc -name 'php.ini')
do
    echo "zend_extension_ts=\"${XDEBUG}\"" >> ${INI}
    echo "xdebug.remote_autostart=1" >> ${INI}
    echo "xdebug.remote_enable=1" >> ${INI}
    echo "xdebug.remote_connect_back=1" >> ${INI}
    echo "xdebug.remote_port=9002" >> ${INI}
    echo "xdebug.idekey=PHP_STORM" >> ${INI}
    echo "xdebug.scream=0" >> ${INI}
    echo "xdebug.cli_color=1" >> ${INI}
    echo "xdebug.show_local_vars=1" >> ${INI}
    echo ";var_dump display" >> ${INI}
    echo "xdebug.var_display_max_depth = 5" >> ${INI}
    echo "xdebug.var_display_max_children = 256" >> ${INI}
    echo "xdebug.var_display_max_data = 1024" >> ${INI}
done
# Change settings for unix socket
sed -i 's/^listen =  127.0.0.1:9000/listen = \/var\/run\/php5-fpm.sock/' ${WWW_CONF}
# Create phpinfo() file
cat > ${SITE_PATH}/info.php << EOF
<?php phpinfo(); ?>
EOF
### Install nginx
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}.......................................... Installing Nginx .....................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
echo -ne '\n' | add-apt-repository ppa:nginx/stable
apt-get update
apt-get upgrade -y
apt-get install nginx -y
service nginx stop
# Backup default settings for nginx.conf
cp ${NGINX_CONF} ${NGINX_CONF}.backup
# Configure nginx.conf
sed -i 's/^worker_processes 4;/worker_processes 1;/' ${NGINX_CONF}
# Backup default settings for nginx
cp ${DEFAULT_NGINX_CONF} ${DEFAULT_NGINX_CONF}.backup
# Configure nginx for http://localhost/
cat > ${DEFAULT_NGINX_CONF} << EOF
server {
    listen   80; ## listen for ipv4; this line is default and implied
    listen   [::]:80 default_server ipv6only=on; ## listen for ipv6

    root /usr/share/nginx/html;
    index index.php index.html index.htm;

    SERVER_NAME ${SERVER_NAME};

    location / {
        try_files \$uri \$uri/ /index.php;
    }

    error_page 404 /404.html;
    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }

    # pass the PHP scripts to FastCGI server listening on the php-fpm socket
    location ~ \\.php\$ {

        fastcgi_split_path_info ^(.+\\.php)(/.+)\$;
        try_files \$uri =404;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        #fastcgi_pass 127.0.0.1:9000;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_index index.php;
        include fastcgi_params;
    }

}
EOF
# Add site name to /etc/hosts
echo "127.0.0.1       ${SERVER_NAME}" >> /etc/hosts
# Restart services
service mysql restart
service nginx restart
service php5-fpm restart
### Install mysql-server and phpmyadmin
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}................................. Installing MySQL & phpmyadmin .................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
apt-get update
echo -ne '\n' | add-apt-repository ppa:nijel/phpmyadmin
echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASS" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $MYSQL_ROOT_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOT_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_ROOT_PASS"v	 | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none" | debconf-set-selections
apt-get install mysql-server php5-mysql phpmyadmin -y
ln -s /usr/share/phpmyadmin /usr/share/nginx/html
# Enable mycrypt and restart service
php5enmod mcrypt
service php5-fpm restart
}
lamp() {
### Install LAMP (Apache2 + MySQL + PHPMyAdmin) and configure it
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}............. Installing and Configuring LAMP: Linux + Apache2 + MySQL + phpmyadmin .............${RESET}
echo ${GREEN}.................................................................................................${RESET}
# TODO: Implement LAMP installation
}
virtualBox() {
### Install VirtualBox
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}.................................... Installing VirtualBox  .....................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
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
}
vagrant() {
### Install Vagrant
# Get deb, unpack it and remove after installing
wget https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
dpkg -i vagrant*.deb
apt-get install vagrant -y
apt-get install -f -y
rm -rf vagrant*.deb
}
docker() {
### Install Docker and configure it
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}............................... Installing and Configuring Docker ...............................${RESET}
echo ${GREEN}.................................................................................................${RESET}
# TODO: Implement Docker installation
}
sublime() {
### Install SublimeText 3
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
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}.................................... Installing SublimeText 3 ...................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
echo -ne '\n' | add-apt-repository ppa:webupd8team/sublime-text-3
apt-get update
apt-get install sublime-text-installer -y
}
phpStorm10() {
### Install PhpStorm 10 https://www.jetbrains.com/phpstorm/download/
# Licence server here - https://бэкдор.рф/phpstorm-7-8-9-10-product-key/
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}............................. Installing and Configuring PHPStopm 10 ............................${RESET}
echo ${GREEN}.................................................................................................${RESET}
wget http://download-cf.jetbrains.com/webide/PhpStorm-10.0.3.tar.gz
tar -xvf PhpStorm-10.0.3.tar.gz
# IMPORTANT: For complete installation, you should execute two commands below from Terminal after finishing this script
#cd PhpStorm-*/bin/
#./phpstorm.sh || TRUE
}
hipChat() {
### Install HipChat https://www.hipchat.com/
echo ${GREEN}.................................................................................................${RESET}
echo ${GREEN}...................................... Installing HipChat .......................................${RESET}
echo ${GREEN}.................................................................................................${RESET}
echo osboxes.org | sudo su
echo "deb http://downloads.hipchat.com/linux/apt stable main" > /etc/apt/sources.list.d/atlassian-hipchat.list
wget -O - https://www.hipchat.com/keys/hipchat-linux.key | apt-key add -
apt-get update
apt-get install hipchat
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
"Git" "" on \
"Composer" "" on \
"Codesniffer" "" off \
"SeleniumServer" "" on \
"LEMP" "" on \
"LAMP" "" off \
"VirtualBox" "" on \
"Vagrant" "" on \
"Docker" "" off \
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
		Git)git
		;;
		Composer)composer
		;;
		Codesniffer)codesniffer
		;;
		SeleniumServer)selenium
		;;
		LEMP)lemp
		;;
		LAMP)lamp
		;;
		VirtualBox)virtualBox
		;;
		Vagrant)vagrant
		;;
		Docker)docker
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
