#!/bin/bash

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
# Update & Upgrade
echo ${green}.................................................................................................${reset}
echo ${green}..................................Update and Upgrade the system..................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get update && apt-get upgrade -y
# Install Chrome
echo ${green}.................................................................................................${reset}
echo ${green}.....................................Installing Google Chrome....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i ./google-chrome*.deb
apt-get install -f -y
apt-get install flashplugin-installer
# Install Skype
echo ${green}.................................................................................................${reset}
echo ${green}........................................Installing Skype.........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install -y sni-qt:i386 libdbusmenu-qt2:i386 libqt4-dbus:i386 libxss1:i386
apt-get install -y libgtk2.0-0:i386 gtk2-engines:i386 libgconf-2-4:i386
add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
apt-get update
apt-get install skype -y
apt-get install libasound2-plugins:i386 -y
# Install Tor Browser
echo ${green}.................................................................................................${reset}
echo ${green}......................................Installing Tor Browser.....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:webupd8team/tor-browser
apt-get install tor-browser
# Install SSH
echo ${green}.................................................................................................${reset}
echo ${green}......................................Installing SSH Server......................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get update
apt-get install openssh-client -y
apt-get install openssh-server -y
mkdir ~/.ssh
# Install SublimeText 3
echo ${green}.................................................................................................${reset}
echo ${green}.....................................Installing SublimeText 3....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:webupd8team/sublime-text-3
apt-get update
apt-get install sublime-text-installer -y
# Install Git and Composer
echo ${green}.................................................................................................${reset}
echo ${green}....................................Installing Git and Composer..................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get update
apt-get install git -y
apt-get install tig -y
apt-get install php5-curl -y
apt-get install curl php5-cli git -y
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Install Java
echo ${green}.................................................................................................${reset}
echo ${green}.........................................Installing Java.........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install default-jre -y
apt-get install gcj-4.8-jre-headless -y
echo -ne '\n' | add-apt-repository ppa:webupd8team/java
apt-get install openjdk-7-jre-headless
apt-get install gcj-4.6-jre-headless
apt-get install openjdk-6-jre-headless -y
# Install Shutter
echo ${green}.................................................................................................${reset}
echo ${green}........................................Installing Shutter.......................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:shutter/ppa
apt-get install shutter -y
# Install Apache2 and configure it
echo ${green}.................................................................................................${reset}
echo ${green}................................Installing and Configuring Apache2...............................${reset}
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
echo ${green}.....................................Installing MySQL Server.....................................${reset}
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
echo ${green}.........................................Installing PHP..........................................${reset}
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
echo ${green}......................................Installing PHPMyAdmin......................................${reset}
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
    errRep=$(grep "^error_reporting = " "${ini}")osb
    sed -i "s/${errRep}/error_reporting = E_ALL & ~E_NOTICE" ${ini}

    dispErr=$(grep "^display_errors = " "${ini}")
    sed -i "s/${dispErr}/display_errors = On/g" ${ini}

    dispStrtErr=$(grep "^display_startup_errors = " "${ini}")
    sed -i "s/${dispStrtErr}/display_startup_errors = On/g" ${ini}

    dispHtmlErr=$(grep "^html_errors = " "${ini}")
    sed -i "s/${dispHtmlErr}/html_errors = On/g" ${ini}
done
# xdebug configuring
xdebug=$( cat find / -name 'xdebug.so' 2> /dev/null ) 
echo zend_extension="${xdebug}" > ${php_config_file}
cat <<EOF>> /etc/php/apache2/php.ini
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
# Install Virtualbox and Vagrant
echo ${green}.................................................................................................${reset}
echo ${green}.................................Installing VirtualBox and Vagrant...............................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install virtualbox -y
apt-get install vagrant -y
apt-get install virtualbox-dkms -y
# Install Drupal 7
# Drupal variables
drupal_version="drupal-7.41"
drupal_folder="/var/www/html/${drupal_version}"
drupal_superadmin="admin"
drupal_pass="drupaladm1n"
echo ${green}.................................................................................................${reset}
echo ${green}...............................Installing and Configuring Drupal 7...............................${reset}
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
# Install PhpStorm 10
echo ${green}.................................................................................................${reset}
echo ${green}..............................Installing and Configuring PHPStopm 10.............................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
wget http://download-cf.jetbrains.com/webide/PhpStorm-10.0.2.tar.gz
tar -xvf PhpStorm-10.0.2.tar.gz
cd PhpStorm-143.1184.87/bin/
./phpstorm.sh
# Install HipChat
echo ${green}.................................................................................................${reset}
echo ${green}.......................................Installing HipChat........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo osboxes.org | sudo su
echo "deb http://downloads.hipchat.com/linux/apt stable main" > /etc/apt/sources.list.d/atlassian-hipchat.list
wget -O - https://www.hipchat.com/keys/hipchat-linux.key | apt-key add -
apt-get update
apt-get install hipchat
#exit
echo ${green}.................................................................................................${reset}
echo ${green}...............................................DONE..............................................${reset}
echo ${green}.................................................................................................${reset}

if [ -z "$phpmyadmin_password" ]; then echo "${red}...phpMyAdmin is not installed...${reset}"; else echo "${green}...phpmyadmin_password is set - ${phpmyadmin_password}...${reset}"; fi
if [ -z "$mysql_root_password" ]; then echo "${red}...MySQL is not installed...${reset}"; else echo "${green}...mysql_root_user is set - ${mysql_root_user}...${reset}"/n echo "${green}...mysql_root_password is set - ${mysql_root_password}...${reset}"; fi
if [ -z "$drupal_version" ]; then echo "${red}...Drupal is not installed...${reset}"; else echo "${green}...Drupal version is - ${drupal_version}...${reset}" /n echo "${green}...Path to Drupal folder - ${drupal_folder}...${reset}" /n echo "${green}...Superadmin username is set - ${drupal_superadmin}...${reset}" /n echo "${green}...Password for Superadmin to Drupal - ${drupal_pass}...${reset}"; fi












