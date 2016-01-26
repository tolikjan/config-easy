#!/bin/bash

# This script will be helpful after reinstalling you operating system
# Tested on Ubuntu 14.04.3 64x

# Password for root user for ubuntu box http://sourceforge.net/projects/osboxes/files/vms/vbox/Ubuntu/14.04/14.04.3/Ubuntu_14.04.3-64bit.7z/download
root_pass="osboxes.org"

# coloured variables
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# Update & Upgrade
echo ${green}.................................................................................................${reset}
echo ${green}................................ Update and Upgrade the system ..................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get update && apt-get upgrade -y
# disable guest session
echo "allow-guest=false" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
# Install xclip
echo ${green}.................................................................................................${reset}
echo ${green}........................................ Installing xclip .......................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install xclip -y
# Copies the contents of the id_rsa.pub file to your clipboard with command below
#xclip -sel clip < ~/.ssh/id_rsa.pub
# Install ccsm
echo ${green}.................................................................................................${reset}
echo ${green}........................................ Installing ccsm ........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install compizconfig-settings-manager -y
# For  additional info - http://help.ubuntu.ru/wiki/ccsm
# Install Chrome
echo ${green}.................................................................................................${reset}
echo ${green}................................... Installing Google Chrome ....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
# Another way which occur errors after Updating System
# TODO: Need check whether chrome driver works with selenium 
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
# Install Flash player for Firefox
echo ${green}.................................................................................................${reset}
echo ${green}.............................. Installing Flash player for Firefox ..............................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install flashplugin-installer
# Install Tweak Tools for Ubuntu additional settings
echo ${green}.................................................................................................${reset}
echo ${green}................................... Installing Tweak Tools ......................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install unity-tweak-tool
# Install utilites for archive manager with 7z and rar support
echo ${green}.................................................................................................${reset}
echo ${green}.................................. Installing 7z and Unrar ......................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install p7zip-full -y
sudo apt-get install unrar -y
# Install Skype
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
# Install Tor Browser
echo ${green}.................................................................................................${reset}
echo ${green}................................... Installing Tor Browser ......................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:webupd8team/tor-browser
apt-get update
apt-get install tor-browser -y
# Install uTox http://utox.org/
echo ${green}.................................................................................................${reset}
echo ${green}...................................... Installing uTox ..........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:v-2e/tox
apt-get update
apt-get install utox -y
# Install Telegram messanger
echo ${green}.................................................................................................${reset}
echo ${green}..................................... Installing Telegram .......................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:atareao/telegram
apt-get update
apt-get install telegram -y
# Install Shutter
echo ${green}.................................................................................................${reset}
echo ${green}..................................... Installing Shutter ........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:shutter/ppa
apt-get install shutter -y
# Install SSH
echo ${green}.................................................................................................${reset}
echo ${green}..................................... Installing SSH Server .....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get update
apt-get install openssh-client -y
apt-get install openssh-server -y
mkdir ~/.ssh
chmod 777 -R ~/.ssh/
# Install Git
echo ${green}.................................................................................................${reset}
echo ${green}......................................... Installing Git ........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get update
apt-get install git -y
apt-get install tig -y
# Install Composer
echo ${green}.................................................................................................${reset}
echo ${green}....................................... Installing Composer .....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get update
apt-get install php5-curl -y
apt-get install curl php5-cli git -y
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
chmod 777 -R ~/.composer/
# Install codesnifer for phpStorm
#composer global require drupal/coder
#export PATH="$PATH:$HOME/.composer/vendor/bin"
#phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer
# Install Selenium Server
echo ${green}.................................................................................................${reset}
echo ${green}.................................. Installing Selenium Server ...................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:webupd8team/java
apt-get update
# Create folder for Selenium
mkdir ~/selenium
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
wget -N http://chromedriver.storage.googleapis.com/2.20/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
rm -rf chromedriver_linux64.zip
chmod 777 -R ~/selenium/
# Install LEMP (nginx + MySQL + PHPMyAdmin) and configure it
echo ${green}.................................................................................................${reset}
echo ${green}................... Installing and Configuring LEMP - nginx + MySQL + PHPMyAdmin ................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
# Uninstall/Clear possible extra programs
apt-get purge -y apache2* php5* mysql*
dpkg -l | grep apache*
dpkg -l | grep php5*
dpkg -l | grep mysql*
# Set up variables
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
# php.ini path
php_ini_1="/etc/php5/fpm/php.ini"
php_ini_2="/etc/php5/cli/php.ini"
# Install nginx
echo ${green}.................................................................................................${reset}
echo ${green}.......................................... Installing Nginx .....................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:nginx/stable
apt-get update
apt-get upgrade -y
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
echo "127.0.0.1       ${server_name}" >> /etc/hosts
# Install mysql-server
echo ${green}.................................................................................................${reset}
echo ${green}...................................... Installing MySQL Server ..................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
# Set password for root account
echo "mysql-server mysql-server/root_password password $mysql_root_password" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $mysql_root_password" | debconf-set-selections
apt-get install mysql-server php5-mysql -y
# Install PHP
echo ${green}.................................................................................................${reset}
echo ${green}.......................................... Installing PHP .......................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install php5 php5-fpm php5-mysql php5-cli php5-curl php5-gd php5-mcrypt php5-xdebug -y
# php.ini configuration for displaying errors
for ini in $(find /etc -name 'php.ini')
do
    sed -i 's/^error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/' ${ini}
    sed -i 's/^display_errors = Off/display_errors = On/' ${ini}
    sed -i 's/^display_startup_errors = Off/display_startup_errors = On/' ${ini}
    sed -i 's/^html_errors = Off/html_errors = On/' ${ini}
    sed -i 's/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' ${ini}
    # Change configuration if you planing to load big files
    sed -i 's/^post_max_size = 8M/post_max_size = 200M/' ${ini}
    sed -i 's/^upload_max_filesize = 2M/upload_max_filesize = 200M/' ${ini}
done
# Set up xdebug variable
xdebug=$(find / -name "xdebug.so" 2> /dev/null)
sleep 120
# fpm/php.ini configuration for xdebug
echo "zend_extension_ts=\"${xdebug}\"" >> ${php_ini_1}
echo "xdebug.remote_autostart=1" >> ${php_ini_1}
echo "xdebug.remote_enable=1" >> ${php_ini_1}
echo "xdebug.remote_connect_back=1" >> ${php_ini_1}
echo "xdebug.remote_port=9002" >> ${php_ini_1}
echo "xdebug.idekey=PHP_STORM" >> ${php_ini_1}
echo "xdebug.scream=0" >> ${php_ini_1}
echo "xdebug.cli_color=1" >> ${php_ini_1}
echo "xdebug.show_local_vars=1" >> ${php_ini_1}
echo ";var_dump display" >> ${php_ini_1}
echo "xdebug.var_display_max_depth = 5" >> ${php_ini_1}
echo "xdebug.var_display_max_children = 256" >> ${php_ini_1}
echo "xdebug.var_display_max_data = 1024" >> ${php_ini_1}
# cli/php.ini configuration for xdebug
echo "zend_extension_ts=\"${xdebug}\"" >> ${php_ini_2}
echo "xdebug.remote_autostart=1" >> ${php_ini_2}
echo "xdebug.remote_enable=1" >> ${php_ini_2}
echo "xdebug.remote_connect_back=1" >> ${php_ini_2}
echo "xdebug.remote_port=9002" >> ${php_ini_2}
echo "xdebug.idekey=PHP_STORM" >> ${php_ini_2}
echo "xdebug.scream=0" >> ${php_ini_2}
echo "xdebug.cli_color=1" >> ${php_ini_2}
echo "xdebug.show_local_vars=1" >> ${php_ini_2}
echo ";var_dump display" >> ${php_ini_2}
echo "xdebug.var_display_max_depth = 5" >> ${php_ini_2}
echo "xdebug.var_display_max_children = 256" >> ${php_ini_2}
echo "xdebug.var_display_max_data = 1024" >> ${php_ini_2}
sed -i 's/^listen =  127.0.0.1:9000/listen = /var/run/php5-fpm.sock/' ${www_conf}
# Create phpinfo() file
cat > ${site_path}/info.php << EOF
<?php phpinfo(); ?>
EOF
# Restart services
service mysql restart
service nginx restart
service php5-fpm restart
# Install Virtualbox and Vagrant
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
EOF
# Now, download and register the ORACLE public key
wget -q -O - https://www.virtualbox.org/download/oracle_vbox.asc | sudo apt-key add -  
# Update and install virtualbox
apt-get update
dpkg --configure -a
apt-get install dkms virtualbox-5.0 -y
# Install Extension Pack for VirtualBox
# You can check latest extension pack version here - https://www.virtualbox.org/wiki/Downloads
ext_pack="Oracle_VM_VirtualBox_Extension_Pack-5.0.14.vbox-extpack"
wget http://download.virtualbox.org/virtualbox/5.0.14/${ext_pack}
echo ${root_pass} | VBoxManage extpack install ${ext_pack}
rm -rf ${ext_pack}
# install Vagrant
# Get deb,unpack it and remove after installing
wget https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
dpkg -i vagrant*.deb
apt-get install vagrant -y
apt-get install -f -y
rm -rf vagrant*.deb

# TODO: add Drupal and phpmyadmin

# Install SublimeText 3
# Licence code here - https://gist.github.com/J2TeaM/9f24a57d5832e475fc4d
echo ${green}.................................................................................................${reset}
echo ${green}.................................... Installing SublimeText 3 ...................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
echo -ne '\n' | add-apt-repository ppa:webupd8team/sublime-text-3
apt-get update
apt-get install sublime-text-installer -y
# Install PhpStorm 10
# Licence code here - https://бэкдор.рф/phpstorm-7-8-9-10-product-key/
echo ${green}.................................................................................................${reset}
echo ${green}............................. Installing and Configuring PHPStopm 10 ............................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
wget http://download-cf.jetbrains.com/webide/PhpStorm-10.0.3.tar.gz
tar -xvf PhpStorm-10.0.3.tar.gz
# NOTE: For finishing installation you should execute two commands below
#cd PhpStorm-*/bin/
#./phpstorm.sh || TRUE
# Install HipChat
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
echo ${green}............................................. DONE ..............................................${reset}
echo ${green}.................................................................................................${reset}
