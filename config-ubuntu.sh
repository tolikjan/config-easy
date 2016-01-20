#!/bin/bash

# This script will be helpful after reinstalling you operating system
# Tested on Ubuntu 14.04.3 64x

# Password for root user for ubuntu box http://sourceforge.net/projects/osboxes/files/vms/vbox/Ubuntu/14.04/14.04.3/Ubuntu_14.04.3-64bit.7z/download
root_pass="osboxes.org"

# coloured variables
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

sleep 5
#
# Update & Upgrade
#
echo ${green}.................................................................................................${reset}
echo ${green}................................ Update and Upgrade the system ..................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get update && apt-get upgrade -y
#
# Install Chrome
#
echo ${green}.................................................................................................${reset}
echo ${green}................................... Installing Google Chrome ....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
# Another way which occur errors after Updating System
# TODO: Need check whether chrome driver works with selenium
# 
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
#sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
#sudo apt-get update
#sudo apt-get install google-chrome-stable -y
#
# Get deb,unpack it and remove after installing
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i ./google-chrome*.deb
apt-get install -f -y
rm -rf google-chrome*.deb
#
# Install Flash player for Firefox
#
echo ${green}.................................................................................................${reset}
echo ${green}.............................. Installing Flash player for Firefox ..............................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install flashplugin-installer
#
# Install Tweak Tools for Ubuntu additional settings
#
echo ${green}.................................................................................................${reset}
echo ${green}................................... Installing Tweak Tools ......................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install unity-tweak-tool
#
# Install utilites for archive manager with 7z and rar support
#
echo ${green}.................................................................................................${reset}
echo ${green}.................................. Installing 7z and Unrar ......................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install p7zip-full -y
sudo apt-get install unrar -y
#
# Install Skype
#
echo ${green}.................................................................................................${reset}
echo ${green}..................................... Installing Skype ..........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
# Install dependencies for Skype
apt-get install -y sni-qt:i386 libdbusmenu-qt2:i386 libqt4-dbus:i386 libxss1:i386
apt-get install -y libgtk2.0-0:i386 gtk2-engines:i386 libgconf-2-4:i386
add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
# Install Skype
apt-get update
apt-get install skype -y
# Install sound plugins for fixing problems with sound for Ubuntu
apt-get install libasound2-plugins:i386 -y
#
# Install Tor Browser
#
echo ${green}.................................................................................................${reset}
echo ${green}................................... Installing Tor Browser ......................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:webupd8team/tor-browser
apt-get update
apt-get install tor-browser -y
#
# Install Tox http://utox.org/
#
echo ${green}.................................................................................................${reset}
echo ${green}...................................... Installing uTox ..........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:v-2e/tox
apt-get update
apt-get install utox -y
#
# Install Shutter
#
echo ${green}.................................................................................................${reset}
echo ${green}..................................... Installing Shutter ........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:shutter/ppa
apt-get install shutter -y
#
# Install SSH
#
echo ${green}.................................................................................................${reset}
echo ${green}..................................... Installing SSH Server .....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get update
apt-get install openssh-client -y
apt-get install openssh-server -y
mkdir ~/.ssh
#
# Install Git
#
echo ${green}.................................................................................................${reset}
echo ${green}......................................... Installing Git ........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get update
apt-get install git -y
apt-get install tig -y
#
# Install Composer
#
echo ${green}.................................................................................................${reset}
echo ${green}....................................... Installing Composer .....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get update
apt-get install php5-curl -y
apt-get install curl php5-cli git -y
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Install codesnifer for phpStorm
#composer global require drupal/coder
#export PATH="$PATH:$HOME/.composer/vendor/bin"
#phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer
#
# Install Selenium Server
#
echo ${green}.................................................................................................${reset}
echo ${green}.................................. Installing Selenium Server ...................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:webupd8team/java
apt-get update
# Create folder for Selenium
mkdir ~/selenium
chmod 777 -R selenium/
cd ~/selenium
# Install xvfb - display server wich implementing the X11 display server protocol
apt-get install xvfb -y
# Get Selenium and install headless Java runtime
wget http://selenium-release.storage.googleapis.com/2.48/selenium-server-standalone-2.48.2.jar
apt-get install openjdk-7-jre-headless -y
# Install headless GUI for firefox. Xvfb is a display server that performs graphical operations in memory
#apt-get install xvfb -y
# Starting up Selenium server
#DISPLAY=:1 xvfb-run java -jar ~/selenium/selenium-server-standalone-2.48.2.jar
###
# Install LEMP (nginx + MySQL + PHPMyAdmin) and configure it
###
echo ${green}.................................................................................................${reset}
echo ${green}.............. Installing and Configuring LEMP - Linux + nginx + MySQL + PHPMyAdmin .............${reset}
echo ${green}.................................................................................................${reset}
###
# Set Up variables
###
# TODO: Do something with this fucking web server
# php.ini path
php_config_file1="/etc/php5/fpm/php.ini"
# site folder path
site_path="/usr/share/nginx/html"
server_name="local.com"
# www config
www_conf="/etc/php5/fpm/pool.d/www.conf"
# nginx config
nginx_conf="/etc/nginx/nginx.conf"
# default nginx config
default_nginx_conf="/etc/nginx/sites-available/default"
default_nginx_conf_link="/etc/nginx/sites-enabled/default"
# phpmyadmin config path
phpmyadmin.conf="/etc/nginx/phpmyadmin.conf"
# mysql variables
mysql_config_file="/etc/mysql/my.cnf"
mysql_root_user="root"
mysql_root_password="root"
###
# Install nginx
###
apt-get update
apt-get upgrade -y
# If you need to remove apache2
#apt-get remove apache2* -y
#apt-get autoremove -y
apt-get install nginx -y
service nginx stop
# Backup default settings for nginx.conf
cp ${nginx_conf} ${nginx_conf}.backup
# Configure nginx.conf
sed -i 's/^worker_processes 4;/worker_processes 1;/' ${nginx_conf}
# Backup default settings for nginx
cp ${default_nginx_conf} ${default_nginx_conf}.backup
# Configure nginx for http://localhost/
cat > ${default_nginx_conf} << EOF
server {
    listen   80; ## listen for ipv4; this line is default and implied
    listen   [::]:80 default_server ipv6only=on; ## listen for ipv6

    root /usr/share/nginx/html;
    index index.php index.html index.htm;

    server_name ${server_name};
    
    location / {
        try_files \$uri \$uri/ /index.html;
    }

    error_page 404 /404.html;
    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }

    # pass the PHP scripts to FastCGI server listening on the php-fpm socket
    location ~ \.php\$ {
            try_files $uri =404;
            # With php5-cgi alone:
            #fastcgi_pass 127.0.0.1:9000;
            # With php5-fpm:
            fastcgi_pass unix:/var/run/php5-fpm.sock;
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
            include fastcgi_params;        
    }

}
EOF
###
# Change configuration www.conf
###
sed -i 's/^listen =  127.0.0.1:9000/listen = /var/run/php5-fpm.sock/' ${www_conf}
###
# Install PHP
###
apt-get install php5 php5-fpm php5-mysql php5-curl php5-gd php5-xdebug -y
# Backup default php.ini files
cp ${php_config_file1} ${php_config_file1}.backup
###
# Configuration for /etc/php5/fpm/php.ini
###
# Change configuration for better security and convenience
sed -i 's/^error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/' ${php_config_file1}
sed -i 's/^html_errors = Off/html_errors = On/' ${php_config_file1}
sed -i 's/^display_startup_errors = Off/display_startup_errors = On/' ${php_config_file1}
sed -i 's/^display_errors = Off/display_errors = On/' ${php_config_file1}
sed -i 's/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo = 0/' ${php_config_file1}
# Change configuration if you planing to load big files
sed -i 's/^post_max_size = 8M/post_max_size = 200M/' ${php_config_file1}
sed -i 's/^upload_max_filesize = 2M/upload_max_filesize = 200M/' ${php_config_file1}
###
# xdebug configuring in php.ini file
###
# TODO: check settings for xdebug
xdebug=$(find / -name 'xdebug.so' 2> /dev/null)
echo "zend_extension=\"${xdebug}\"" >> ${php_config_file1}
echo "xdebug.remote_autostart=1" >> ${php_config_file1}
echo "xdebug.remote_enable=1" >> ${php_config_file1}
echo "xdebug.remote_connect_back=1" >> ${php_config_file1}
echo "xdebug.remote_port=9002" >> ${php_config_file1}
echo "xdebug.idekey=PHP_STORM" >> ${php_config_file1}
echo "xdebug.scream=0" >> ${php_config_file1}
echo "xdebug.cli_color=1" >> ${php_config_file1}
echo "xdebug.show_local_vars=1" >> ${php_config_file1}
echo ";var_dump display" >> ${php_config_file1}
echo "xdebug.var_display_max_depth = 5" >> ${php_config_file1}
echo "xdebug.var_display_max_children = 256" >> ${php_config_file1}
echo "xdebug.var_display_max_data = 1024" >> ${php_config_file1}
###
# Install mysql-server
###
# Set password for root account
echo "mysql-server mysql-server/root_password password $mysql_root_password" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $mysql_root_password" | debconf-set-selections
apt-get install mysql-server php5-mysql -y
# Create phpinfo() file
cat > ${site_path}/info.php << EOF
<?php
echo phpinfo();
EOF
###
# Give permissions for log files and for site folder
###
chmod 777 -R /var/log/nginx/access.log
chmod 777 -R /var/log/nginx/error.log
chmod 777 -R ${site_path}
# Add site name to /etc/hosts
echo "127.0.0.1       ${server_name}" >> /etc/hosts
# Restart services
service mysql restart
service nginx restart
service php5-fpm restart
###
# Install Virtualbox and Vagrant
###
echo ${green}.................................................................................................${reset}
echo ${green}................................ Installing VirtualBox and Vagrant ..............................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
# IMPORTANT! Before using VirtualBox, make sure that virtualization is enabled in your BIOS settings
# IMPORTANT! Make sure that VirtualBox not running right now
# Uninstall VirtualBox if it was installed previously
apt-get purge "^virtualbox-.*" -y
apt-get update
# Clean up
apt-get autoremove -y | apt-get autoclean - y | apt-get clean -y
# Add deb
cat > /etc/apt/sources.list.d/oracle-vbox.list << EOF
deb http://download.virtualbox.org/virtualbox/debian trusty contrib  
# deb-src http://download.virtualbox.org/virtualbox/debian trusty contrib
EOL
# Now, download and register the ORACLE public key
wget -q -O - https://www.virtualbox.org/download/oracle_vbox.asc | sudo apt-key add -  
# Update and install virtualbox
apt-get update
dpkg --configure -a
apt-get install dkms virtualbox-5.0 -y
# Install Extension Pack for VirtualBox
# You can check latest extension pack version here - https://www.virtualbox.org/wiki/Downloads
ext_pack="Oracle_VM_VirtualBox_Extension_Pack-5.0.12-104815.vbox-extpack"
wget http://download.virtualbox.org/virtualbox/5.0.12/${ext_pack}
rm -rf ${ext_pack}
echo ${root_pass} | VBoxManage extpack install ${ext_pack}
# install Vagrant
# Get deb,unpack it and remove after installing
wget https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
dpkg -i vagrant*.deb
apt-get install vagrant -y
apt-get install -f -y
rm -rf vagrant*.deb
echo ${green}.................................................................................................${reset}
echo ${green}.............................................. DONE .............................................${reset}
echo ${green}.................................................................................................${reset}
