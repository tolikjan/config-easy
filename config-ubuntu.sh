#!/bin/bash

# This script will be helpful after reinstalling you operating system
# Tested on Ubuntu 14.04.3 64x

# Password for root user
root_pass="osboxes.org"

# coloured variables
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# php variables
#php_config_file="/etc/php5/cli/php.ini"
directory_config_file="/etc/apache2/mods-enabled/dir.conf"

# mysql variables
mysql_config_file="/etc/mysql/my.cnf"
mysql_root_user="root"
mysql_root_password="root"
phpmyadmin_password="root"

sleep 5
#
# Update & Upgrade
#
echo ${green}.................................................................................................${reset}
echo ${green}................................. Update and Upgrade the system .................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get update && apt-get upgrade -y
#
# Install Chrome
#
echo ${green}.................................................................................................${reset}
echo ${green}.................................... Installing Google Chrome ...................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
#sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
#sudo apt-get update
#sudo apt-get install google-chrome-stable -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i ./google-chrome*.deb
apt-get install -f -y
rm -rf google-chrome-stable_current_amd64.deb
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
echo ${green}..................................... Installing Tweak Tools ....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install unity-tweak-tool
#
# Install utilites for archive manager with 7z and rar support
#
echo ${green}.................................................................................................${reset}
echo ${green}.................................... Installing 7z and Unrar ....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install p7zip-full -y
sudo apt-get install unrar -y
#
# Install Skype
#
echo ${green}.................................................................................................${reset}
echo ${green}....................................... Installing Skype ........................................${reset}
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
echo ${green}..................................... Installing Tor Browser ....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:webupd8team/tor-browser
apt-get update
apt-get install tor-browser -y
#
# Install Shutter
#
echo ${green}.................................................................................................${reset}
echo ${green}....................................... Installing Shutter ......................................${reset}
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
# Get Selenium and install headless Java runtime
wget http://selenium-release.storage.googleapis.com/2.44/selenium-server-standalone-2.44.0.jar
apt-get install openjdk-7-jre-headless -y
# Install headless GUI for firefox. Xvfb is a display server that performs graphical operations in memory
#apt-get install xvfb -y
# Starting up Selenium server
#DISPLAY=:1 xvfb-run java -jar ~/selenium/selenium-server-standalone-2.44.0.jar
#
# Install LEMP (nginx + MySQL + PHPMyAdmin) and configure it
#
echo ${green}.................................................................................................${reset}
echo ${green}.............. Installing and Configuring LEMP - Linux + nginx + MySQL + PHPMyAdmin .............${reset}
echo ${green}.................................................................................................${reset}
# Set Up variables
# TODO: add fastcgi conf.
php_config_file="/etc/php5/fpm/php.ini"
www_conf="/etc/php5/fpm/pool.d/www.conf"
fastcgi_conf="/etc/nginx/fastcgi.conf"
nginx_conf="/etc/nginx/sites-available/default"
nginx_conf_link="/etc/nginx/sites-enabled/default"
server_name="my.localhost.com"
php_info_path="/usr/share/nginx/html/${server_name}/info.php"
# Install nginx
apt-get update
 apt-get install nginx nginx-extras -y
service nginx start
# Set password for root account
echo "mysql-server mysql-server/root_password password "${mysql_root_password} | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password "${mysql_root_password} | debconf-set-selections
# Install MySQL-server
apt-get install mysql-server -y
# We should activate MySQL with this command:
mysql_install_db
# Run secure instalation for MySQL
echo "mysql-server mysql-server/root_password password "${mysql_root_password} | debconf-set-selections
# install PHP and php-packages
apt-get install php5 php5-cli php5-common php5-mysql php5-gd php5-fpm php5-cgi php5-fpm php-pear php5-mcrypt php5-xdebug -y
# Stop services
service nginx stop
service php5-fpm stop
# Change configuration for better security and convenience
sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g" ${php_config_file}
sed -i "s/html_errors = Off/html_errors = On/g" ${php_config_file}
sed -i "s/display_startup_errors = Off/display_startup_errors = On/g" ${php_config_file}
sed -i "s/display_errors = Off/display_errors = On/g" ${php_config_file}
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" ${php_config_file}
# Change configuration if you planing to load big files
sed -i "s/post_max_size = 8M/post_max_size = 200M/g" ${php_config_file}
sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 200M/g" ${php_config_file}
# Change configuration www.conf
sed -i "s/;security.limit_extensions = .php .php3 .php4 .php5/security.limit_extensions = .php .php3 .php4 .php5/g" ${www_conf}
sed -i "s/;listen.mode = 0660/listen.mode = 0660/g" ${www_conf}
service php5-fpm start
# Configure nginx conf. file for our site
cp ${nginx_conf} ${nginx_conf}.backup
mkdir /usr/share/nginx/html/${server_name}
rm -rf ${nginx_conf}
rm -rf ${nginx_conf_link}
cat > /etc/nginx/sites-available/${server_name} << EOF
	server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;
        root /usr/share/nginx/html/${server_name};
        index index.php index.html index.htm;
        server_name ${server_name};
        location / {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            try_files \$uri \$uri/ =404;
            # Uncomment to enable naxsi on this location
            # include /etc/nginx/naxsi.rules
        }
        error_page 404 /404.html;
        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
            root /usr/share/nginx/html;
        }
        location ~ \.php$ {
            try_files \$uri =404;
            include ${fastcgi_conf};
    		fastcgi_pass  127.0.0.1:9000;
        }
    }
EOF
# Configure fastcgi conf. file for our site
cat > ${fastcgi_conf} << EOF
	#fastcgi.conf
	fastcgi_param  GATEWAY_INTERFACE  CGI/1.1;
	fastcgi_param  SERVER_SOFTWARE    nginx;
	fastcgi_param  QUERY_STRING       $query_string;
	fastcgi_param  REQUEST_METHOD     $request_method;
	fastcgi_param  CONTENT_TYPE       $content_type;
	fastcgi_param  CONTENT_LENGTH     $content_length;
	fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;
	fastcgi_param  SCRIPT_NAME        $fastcgi_script_name;
	fastcgi_param  REQUEST_URI        $request_uri;
	fastcgi_param  DOCUMENT_URI       $document_uri;
	fastcgi_param  DOCUMENT_ROOT      $document_root;
	fastcgi_param  SERVER_PROTOCOL    $server_protocol;
	fastcgi_param  REMOTE_ADDR        $remote_addr;
	fastcgi_param  REMOTE_PORT        $remote_port;
	fastcgi_param  SERVER_ADDR        $server_addr;
	fastcgi_param  SERVER_PORT        $server_port;
	fastcgi_param  SERVER_NAME        $server_name;
EOF
ln -s /etc/nginx/sites-available/${server_name} /etc/nginx/sites-enabled/
# Give permissions for log file
chmod 777 -R /var/log/nginx/error.log
# Create phpinfo() file
cat > ${php_info_path} << EOF
	<?php
	phpinfo();
	?>
EOF
chmod 777 -R ${php_info_path}
# xdebug configuring
# TODO: check settings for xdebug
xdebug="$(cat find / -name 'xdebug.so' 2> /dev/null)" 
echo "zend_extension="${xdebug}"" >> ${php_config_file}
cat > /etc/php/apache2/php.ini << EOF
    xdebug.remote_autostart=1
    xdebug.remote_enable=1
    xdebug.remote_connect_back=1
    xdebug.remote_port=9002
    xdebug.idekey=PHP_STORM
    xdebug.scream=0
    xdebug.cli_color=1
    xdebug.show_local_vars=1

    ;var_dump display
    xdebug.var_display_max_depth = 5
    xdebug.var_display_max_children = 256
    xdebug.var_display_max_data = 1024
EOF
# Restart services
service mysql restart
service nginx restart
service php5-fpm restart
#
# Install Virtualbox and Vagrant
#
echo ${green}.................................................................................................${reset}
echo ${green}................................ Installing VirtualBox and Vagrant ..............................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
# Before using VirtualBox, make sure that virtualization is enabled in your BIOS settings
apt-get install virtualbox -y
apt-get install virtualbox-dkms -y
# Install Extension Pack for VirtualBox
# You can check latest extension pack version here - https://www.virtualbox.org/wiki/Downloads
#ext_pack="Oracle_VM_VirtualBox_Extension_Pack-5.0.12-104815.vbox-extpack"
#wget http://download.virtualbox.org/virtualbox/5.0.12/${ext_pack}
#echo ${root_pass} | VBoxManage extpack install ${ext_pack}
# install Vagrant
apt-get install vagrant -y
echo ${green}.................................................................................................${reset}
echo ${green}.............................................. DONE .............................................${reset}
echo ${green}.................................................................................................${reset}

