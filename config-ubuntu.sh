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
php_config_file="/etc/php5/cli/php.ini"
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
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable
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
# TODO: fix instalation for Tor Browser
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
# Install Java
#
echo ${green}.................................................................................................${reset}
echo ${green}........................................ Installing Java ........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:webupd8team/java
apt-get update
# To install Oracle JDK:
apt-get install oracle-java7-installer -y
# To automatically set up the Java 7 environment variables JAVA_HOME and PATH:
#apt-get install oracle-java7-set-default -y
# To install the Java Runtime Environment (JRE):
apt-get install openjdk-7-jre -y
# To install OpenJDK 7:
apt-get install openjdk-7-jdk -y
# To install Java runtime environment using GIJ/Classpath (headless version):
apt-get install gcj-4.9-jre-headless -y
#
# Install LEMP (nginx + MySQL + PHPMyAdmin) and configure it
#
echo ${green}.................................................................................................${reset}
echo ${green}.............. Installing and Configuring LEMP (Linux + nginx + MySQL + PHPMyAdmin) .............${reset}
echo ${green}.................................................................................................${reset}
# Set Up variables
php_config_file="/etc/php5/fpm/php.ini"
www_conf="/etc/php5/fpm/pool.d/www.conf"
nginx_conf="/etc/nginx/sites-available/default"
server_name="localhost.com"
php_info_path="/usr/share/nginx/html/info.php"
# Update
apt-get update
# Set password for root account
echo "mysql-server mysql-server/root_password password "${mysql_root_password} | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password "${mysql_root_password} | debconf-set-selections
# Install MySQL-server
apt-get install mysql-server mysql-client php5-mysql -y
# We should activate MySQL with this command:
mysql_install_db
# Run secure instalation for MySQL
echo "mysql-server mysql-server/root_password password "${mysql_root_password} | debconf-set-selections
/usr/bin/mysql_secure_installation -y
# TODO: should check this step above
# Install nginx on the VPS
echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/nginx-stable.list
echo -ne '\n' | apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C
apt-get update
apt-get install nginx -y
service nginx start
# Install PHP
apt-get install php5-cli php5-common php5-mysql php5-suhosin php5-gd php5-fpm php5-cgi php5-fpm php-pear curl libcurl3 libcurl3-dev php5-curl php5-mcrypt -y
# Change configuration for better security
sed -i "s/;cgi.fix_pathinfo = 1/cgi.fix_pathinfo = 0" ${php_config_file}
sed -i "s/listen = 127.0.0.1:9000/listen = /var/run/php5-fpm.sock" ${www_conf}
service php5-fpm restart
# Configure nginx conf.
cp ${nginx_conf} ${nginx_conf}.backup
cat > ${nginx_conf} << EOF
	server {
    	listen 80 default_server;
    	listen [::]:80 default_server ipv6only=on;

    	root /usr/share/nginx/html;
    	index index.php index.html index.htm;

    	server_name ${server_name};

    	location / {
        	try_files $uri $uri/ =404;
    	}

    	error_page 404 /404.html;
    	error_page 500 502 503 504 /50x.html;
    	location = /50x.html {
        	root /usr/share/nginx/html;
    	}

    	location ~ \.php$ {
        	try_files $uri =404;
        	fastcgi_split_path_info ^(.+\.php)(/.+)$;
        	fastcgi_pass unix:/var/run/php5-fpm.sock;
        	fastcgi_index index.php;
        	fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        	include fastcgi_params;
    	}
	}
EOF
# Restart nginx
service nginx restart
# Install Memcached
apt-get install memcached php5-memcached
service php5-fpm restart
service nginx restart
# Create phpinfo() file
cat > ${php_info_path} << EOF
	<?php
	phpinfo();
	?>
EOF







# Install Apache2 and configure it
echo ${green}.................................................................................................${reset}
echo ${green}............................... Installing and Configuring Apache2 ..............................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install apache2 libapache2-mod-php5 -y
a2enmod rewrite ssl
# Config servername
echo "ServerName localhost" > /etc/apache2/conf-available/fqdn.conf
a2enconf fqdn
# Setting SSL for default site
apt-get install ssl-cert -y
a2ensite default-ssl
# Enable mod_rewrite
a2enmod rewrite
# Enable mod_ssl
a2enmod ssl
service apache2 restart
# Install MySQL
echo ${green}.................................................................................................${reset}
echo ${green}.................................... Installing MySQL Server ....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
# Set password for root account
echo "mysql-server mysql-server/root_password password "${mysql_root_password} | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password "${mysql_root_password} | debconf-set-selections
# Install mysql-server
apt-get install mysql-server php5-mysql -y
# Create informations
mysql_install_db
# Allow connections to this server from outside
sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" ${mysql_config_file}
mysql -u${mysql_root_user} -p${mysql_root_password} -e "GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY '$mysql_root_password';"
mysql -u${mysql_root_user} -p${mysql_root_password} -e "FLUSH PRIVILEGES;"
service mysql stop
service mysql start
# Install php5
echo ${green}.................................................................................................${reset}
echo ${green}........................................ Installing PHP .........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install php5 php5-common php5-dev php5-cli php5-fpm -y
# Install PHP extensions
apt-get install php5-mysql php5-pgsql -y
apt-get install curl php5-curl php5-gd php-db php5-mcrypt php5-imagick php5-intl php5-xdebug -y
apt-get install php5-memcached php5-memcache php5-json -y
# Enable php5-mcrypt mode
php5enmod mcrypt
echo ${green}.................................................................................................${reset}
echo ${green}..................................... Installing PHPMyAdmin .....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
# Install PhpMyAdmin
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-user string root" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password "${mysql_root_password} | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password "${phpmyadmin_root_password} |debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password "${phpmyadmin_password} | debconf-set-selections
apt-get install phpmyadmin -y
# Disable by default, as this will add to all VirtualHosts; instead, add the following to an Apache VirtualHost:
echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
service apache2 reload
# PHP Error Reporting Config
for ini in $(find /etc -name "php.ini")
do
    errRep=$(grep "^error_reporting = " "${ini}")
    sed -i "s/${errRep}/error_reporting = E_ALL" ${ini}

    dispErr=$(grep "^display_errors = " "${ini}")
    sed -i "s/${dispErr}/display_errors = On/g" ${ini}

    dispStrtErr=$(grep "^display_startup_errors = " "${ini}")
    sed -i "s/${dispStrtErr}/display_startup_errors = On/g" ${ini}

    dispHtmlErr=$(grep "^html_errors = " "${ini}")
    sed -i "s/${dispHtmlErr}/html_errors = On/g" ${ini}
done
# xdebug configuring
# TODO: check settings for xdebug
xdebug=$( cat find / -name 'xdebug.so' 2> /dev/null ) 
echo "zend_extension="${xdebug}"" >> ${php_config_file}
cat > /etc/php/apache2/php.ini << EOF
    xdebug.remote_autostart=1
    xdebug.remote_enable=1
    xdebug.remote_connect_back=1
    xdebug.remote_port=9000
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
service apache2 restart
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
# Install Drupal 7
# Drupal variables
drupal_version="drupal-7.41"
drupal_folder="/var/www/html/${drupal_version}"
drupal_superadmin="admin"
drupal_pass="drupaladm1n"
echo ${green}.................................................................................................${reset}
echo ${green}.............................. Installing and Configuring Drupal 7 ..............................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
# Create DataBase for Drupal
mysql -u${mysql_root_user} -p${mysql_root_password} -e "CREATE DATABASE drupal;"
mysql -u${mysql_root_user} -p${mysql_root_password} -e "CREATE USER drupaluser@localhost IDENTIFIED BY 'root';"
mysql -u${mysql_root_user} -p${mysql_root_password} -e "GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,INDEX,ALTER,CREATE TEMPORARY TABLES,LOCK TABLES ON drupal.* TO drupaluser@localhost;"
mysql -u${mysql_root_user} -p${mysql_root_password} -e "FLUSH PRIVILEGES;"
service mysql stop
service mysql start
a2enmod rewrite
service apache2 restart
# Install Drush
apt-get install drush -y
# TODO: Fix Drupal problems
# Install Drupal
cd /var/www/html
drush dl ${drupal_version} -y
mkdir ${drupal_folder}/sites/default/files
mkdir ${drupal_folder}/sites/all/modules/contrib
mkdir ${drupal_folder}/sites/all/modules/contrib
mkdir ${drupal_folder}/sites/all/modules/custom
cd ${drupal_folder}
drush site-install standard --account-name=${drupal_superadmin} --account-pass=${drupal_pass} --db-url=mysql://${mysql_root_user}:${mysql_root_password}@localhost/drupal -y
cd ${drupal_folder}/sites/all/modules/contrib
drush en globalredirect, admin_menu, views, pathauto, elysia_cron, imce, subpathauto, transliteration, token, ctools, link, email, menu_block, views_bulk_operations, nodequeue, field_group, devel, auto_nodetitle, date, masquerade, page_title, module_filter -y
cp /var/www/html/sites/default/default.settings.php ${drupal_folder}/sites/default/settings.php
chmod 664 ${drupal_folder}/sites/default/settings.php
chown -R :www-data /var/www/html/*
# TODO: add /etc/hosts configuration and config files in sites-available (sites enabled)
#
# Install SublimeText 3
#
# Licence code here - https://gist.github.com/J2TeaM/9f24a57d5832e475fc4d
echo ${green}.................................................................................................${reset}
echo ${green}.................................... Installing SublimeText 3 ...................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:webupd8team/sublime-text-3
apt-get update
apt-get install sublime-text-installer -y
#
# Install PhpStorm 10
#
# TODO: solve problems with pop-ups in PHP Storm
# Licence code here - https://бэкдор.рф/phpstorm-7-8-9-10-product-key/
echo ${green}.................................................................................................${reset}
echo ${green}............................. Installing and Configuring PHPStopm 10 ............................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
wget http://download-cf.jetbrains.com/webide/PhpStorm-10.0.2.tar.gz
tar -xvf PhpStorm-10.0.2.tar.gz
cd PhpStorm-143.1184.87/bin/
./phpstorm.sh || TRUE
#
# Install HipChat
#
echo ${green}.................................................................................................${reset}
echo ${green}...................................... Installing HipChat .......................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo osboxes.org | sudo su
echo "deb http://downloads.hipchat.com/linux/apt stable main" > /etc/apt/sources.list.d/atlassian-hipchat.list
wget -O - https://www.hipchat.com/keys/hipchat-linux.key | apt-key add -
apt-get update
apt-get install hipchat
#exit
echo ${green}.................................................................................................${reset}
echo ${green}.............................................. DONE .............................................${reset}
echo ${green}.................................................................................................${reset}
#
# Print credentials
#
if [[ $phpmyadmin_password ]]; then echo "${red}...phpMyAdmin is not installed...${reset}"; else echo "${green}...phpmyadmin_password is set - ${phpmyadmin_password}...${reset}"; fi
if [[ $mysql_root_password ]]; then echo "${red}...MySQL is not installed...${reset}"; else echo "${green}...mysql_root_user is set - ${mysql_root_user}...${reset}" '\n' "${green}...mysql_root_password is set - ${mysql_root_password}...${reset}"; fi
if [[ $drupal_version ]]; then echo "${red}...Drupal is not installed...${reset}"; else echo "${green}...Drupal version is - ${drupal_version}...${reset}" '\n' "${green}...Path to Drupal folder - ${drupal_folder}...${reset}" '\n' "${green}...Superadmin username is set - ${drupal_superadmin}...${reset}" '\n' "${green}...Password for Superadmin to Drupal - ${drupal_pass}...${reset}"; fi

