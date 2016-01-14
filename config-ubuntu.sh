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
# Install xvfb - display server wich implementing the X11 display server protocol
apt-get install xvfb -y
# Get Selenium and install headless Java runtime
wget http://selenium-release.storage.googleapis.com/2.48/selenium-server-standalone-2.48.2.jar
apt-get install openjdk-7-jre-headless -y
# Install headless GUI for firefox. Xvfb is a display server that performs graphical operations in memory
#apt-get install xvfb -y
# Starting up Selenium server
#DISPLAY=:1 xvfb-run java -jar ~/selenium/selenium-server-standalone-2.48.2.jar
#
# Install LEMP (nginx + MySQL + PHPMyAdmin) and configure it
#
echo ${green}.................................................................................................${reset}
echo ${green}.............. Installing and Configuring LEMP - Linux + nginx + MySQL + PHPMyAdmin .............${reset}
echo ${green}.................................................................................................${reset}
###
# Set Up variables
###
# TODO: Do something with this fucking web server
# php.ini path
php_config_file1="/etc/php5/fpm/php.ini"
php_config_file2="/etc/php5/cli/php.ini"
php_config_file3="/etc/php5/cgi/php.ini"
# site folder path
site_path="/usr/share/nginx/html"
server_name="local.host.com"
# www config
www_conf="/etc/php5/fpm/pool.d/www.conf"
# nginx config
nginx_conf="/etc/nginx/conf.d/nginx.conf"
# default nginx config
default_nginx_conf="/etc/nginx/sites-available/default"
default_nginx_conf_link="/etc/nginx/sites-enabled/default"
# additional config
basic_settings="/etc/nginx/basic_settings"
client_settings="/etc/nginx/client_settings"
fastcgi_caches="/etc/nginx/fastcgi_caches"
fastcgi_params="/etc/nginx/fastcgi_params"
gzip_settings="/etc/nginx/gzip_settings"
client_settings="/etc/nginx/client_settings"
mime.types="/etc/nginx/mime.types"
# phpmyadmin config
phpmyadmin.conf="/etc/nginx/phpmyadmin.conf"
phpmyadmin_root_password="root"
# mysql variables
mysql_config_file="/etc/mysql/my.cnf"
mysql_root_user="root"
mysql_root_password="root"
###
# Install nginx
###
apt-get update
apt-get install nginx -y
service nginx start
# Backup default settings for nginx.conf
cp ${nginx_conf} ${nginx_conf}.backup
# Configure nginx.conf
cat > ${nginx_conf} << EOF
user www-data;
 
# As a thumb rule: One per CPU. If you are serving a large amount
# of static files, which requires blocking disk reads, you may want
# to increase this from the number of cpu_cores available on your
# system.
#
# The maximum number of connections for Nginx is calculated by:
# max_clients = worker_processes * worker_connections
worker_processes 1;
 
# Maximum file descriptors that can be opened per process
# This should be > worker_connections
worker_rlimit_nofile 8192;
 
events {
    # When you need > 8000 * cpu_cores connections, you start optimizing
    # your OS, and this is probably the point at where you hire people
    # who are smarter than you, this is *a lot* of requests.
    worker_connections 8000;
}
 
error_log /var/log/nginx/error.log;
 
pid /var/run/nginx.pid;
 
http {
    charset utf-8;
 
    # Set the mime-types via the mime.types external file
    include mime.types;
 
    # And the fallback mime-type
    default_type application/octet-stream;
 
    # Click tracking!
    access_log /var/log/nginx/access.log;
 
    # Hide nginx version
    server_tokens off;
 
    # ~2 seconds is often enough for HTML/CSS, but connections in
    # Nginx are cheap, so generally it's safe to increase it
    keepalive_timeout 20;
 
    # You usually want to serve static files with Nginx
    sendfile on;
 
    tcp_nopush on; # off may be better for Comet/long-poll stuff
    tcp_nodelay off; # on may be better for Comet/long-poll stuff
 
    server_name_in_redirect off;
    types_hash_max_size 2048;
 
    gzip on;
    gzip_http_version 1.0;
    gzip_comp_level 5;
    gzip_min_length 512;
    gzip_buffers 4 8k;
    gzip_proxied any;
    gzip_types
        # text/html is always compressed by HttpGzipModule
        text/css
        text/plain
        text/x-component
        application/javascript
        application/json
        application/xml
        application/xhtml+xml
        application/x-font-ttf
        application/x-font-opentype
        application/vnd.ms-fontobject
        image/svg+xml
        image/x-icon;
 
    # This should be turned on if you are going to have pre-compressed copies (.gz) of
    # static files available. If not it should be left off as it will cause extra I/O
    # for the check. It would be better to enable this in a location {} block for
    # a specific directory:
    # gzip_static on;
 
    gzip_disable "msie6";
    gzip_vary on;
 
    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}
EOF
# Backup default settings for nginx
cp ${default_nginx_conf} ${default_nginx_conf}.backup
# Configure nginx for http://localhost/
cat > ${default_nginx_conf} << EOF
server {
    listen 80 default; ## listen for ipv4; this line is default and implied
    listen [::]:80 default ipv6only=on; ## listen for ipv6

    root /usr/share/nginx/html;
    index index.php index.html index.htm;

    server_name ${server_name};

    location / {
        try_files \$uri \$uri/ =404;
    }

    error_page 404 /404.html;
    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }

    location ~ \.php\$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\\.php)(/.+)\$;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }
    
    ## Include phpmyadmin location here
    include phpmyadmin.conf;
    
    location /doc/ {
        alias /usr/share/doc/;
        allow 127.0.0.1;
        allow ::1;
        deny all;
    }

}
EOF
# Restart nginx
service nginx restart
###
# Install mysql-server
###
# Set password for root account
echo "mysql-server mysql-server/root_password password "${mysql_root_password} | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password "${mysql_root_password} | debconf-set-selections
###
# Install MySQL-server
###
apt-get install mysql-server php5-mysql -y
#
echo ${green}.................................................................................................${reset}
echo ${green}........................................ Installing PHP .........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install php5 php5-common php5-cli php5-fpm php5-gd php5-xdebug -y
# Backup default php.ini files
cp ${php_config_file1} ${php_config_file1}.backup
cp ${php_config_file2} ${php_config_file2}.backup
cp ${php_config_file3} ${php_config_file3}.backup
# Stop services
service nginx stop
service php5-fpm stop
###
# Configuration for /etc/php5/fpm/php.ini
###
# Change configuration for better security and convenience
sed -i 's/^error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g' ${php_config_file1}
sed -i 's/^html_errors = Off/html_errors = On/g' ${php_config_file1}
sed -i 's/^display_startup_errors = Off/display_startup_errors = On/g' ${php_config_file1}
sed -i 's/^display_errors = Off/display_errors = On/g' ${php_config_file1}
sed -i 's/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${php_config_file1}
# Change configuration if you planing to load big files
sed -i 's/^post_max_size = 8M/post_max_size = 200M/g' ${php_config_file1}
sed -i 's/^upload_max_filesize = 2M/upload_max_filesize = 200M/g' ${php_config_file1}
###
# Configuration for /etc/php5/cli/php.ini
###
# Change configuration for better security and convenience
sed -i 's/^error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g' ${php_config_file2}
sed -i 's/^html_errors = Off/html_errors = On/g' ${php_config_file2}
sed -i 's/^display_startup_errors = Off/display_startup_errors = On/g' ${php_config_file2}
sed -i 's/^display_errors = Off/display_errors = On/g' ${php_config_file2}
sed -i 's/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${php_config_file2}
# Change configuration if you planing to load big files
sed -i 's/^post_max_size = 8M/post_max_size = 200M/g' ${php_config_file2}
sed -i 's/^upload_max_filesize = 2M/upload_max_filesize = 200M/g' ${php_config_file2}
###
# Change configuration www.conf
###
sed -i 's/^;security.limit_extensions = .php .php3 .php4 .php5/security.limit_extensions = .php .php3 .php4 .php5/g' ${www_conf}
sed -i 's/^;listen.mode = 0660/listen.mode = 0660/g' ${www_conf}
sed -i 's/^listen =  127.0.0.1:9000/listen = /var/run/php5-fpm.sock/g' ${www_conf}
###
# Give permissions for log file
###
chmod 777 -R /var/log/nginx/access.log
chmod 777 -R /var/log/nginx/error.log
# Create phpinfo() file
cat > ${site_path}/info.php << EOF
<?php
phpinfo();
?>
EOF
chmod 777 -R ${site_path}
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
# xdebug configuring in php.ini file
###
# TODO: check settings for xdebug
xdebug=$(find / -name 'xdebug.so' 2> /dev/null)
echo "zend_extension=\"${xdebug}\"" >> ${php_config_file2}
echo "xdebug.remote_autostart=1" >> ${php_config_file2}
echo "xdebug.remote_enable=1" >> ${php_config_file2}
echo "xdebug.remote_connect_back=1" >> ${php_config_file2}
echo "xdebug.remote_port=9002" >> ${php_config_file2}
echo "xdebug.idekey=PHP_STORM" >> ${php_config_file2}
echo "xdebug.scream=0" >> ${php_config_file2}
echo "xdebug.cli_color=1" >> ${php_config_file2}
echo "xdebug.show_local_vars=1" >> ${php_config_file2}
echo ";var_dump display" >> ${php_config_file2}
echo "xdebug.var_display_max_depth = 5" >> ${php_config_file2}
echo "xdebug.var_display_max_children = 256" >> ${php_config_file2}
echo "xdebug.var_display_max_data = 1024" >> ${php_config_file2}
# Add site name to /etc/hosts
echo "127.0.0.1       ${server_name}" >> /etc/hosts
# Restart services
service mysql restart
service nginx restart
service php5-fpm restart
###
# Install PhpMyAdmin
###
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-user string root" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password "${mysql_root_password} | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password "${phpmyadmin_root_password} |debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password "${phpmyadmin_root_password} | debconf-set-selections
apt-get install phpmyadmin -y
# Configure nginx.conf
cat > ${phpmyadmin.conf} << EOF
# PhpMyAdmin configuration
location /phpmyadmin {
       root /usr/share/;
       index index.php index.html index.htm;
       location ~ ^/phpmyadmin/(.+\\.php)\$ {
               try_files \$uri =404;
               root /usr/share/;
               #fastcgi_pass 127.0.0.1:9000;
               fastcgi_pass unix:/tmp/php5-fpm.sock;
               fastcgi_index index.php;
               fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
               include fastcgi_params;
       }
       location ~* ^/phpmyadmin/(.+\\.(jpg|jpeg|gif|css|png|js|ico|html|xml|txt))\$ {
               root /usr/share/;
       }
}
location /phpMyAdmin {
       rewrite ^/* /phpmyadmin last;
}
EOF
# Create a symbolic link between phpMyAdmin and website root directory
cd ${site_path}
ln -s /usr/share/phpmyadmin/
chmod 777 -R ${site_path}/phpmyadmin
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
cat > /etc/apt/sources.list.d/oracle-vbox.list << EOL
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
###
# Install Gimp, Vine and PlayOnLinux
###
echo ${green}.................................................................................................${reset}
echo ${green}................................ Installing Gimp and PlatOnLinux ................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
# install latest version of Gimp editor
#echo -ne '\n' | add-apt-repository ppa:otto-kesselgulasch/gimp
#apt-get update && sudo apt-get install gimp -y

# TODO: fix two screens
#echo -ne '\n' | add-apt-repository ppa:ubuntu-wine/ppa
#apt-get update
#apt-get install wine1.7 -y

#wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
#wget http://deb.playonlinux.com/playonlinux_trusty.list -O /etc/apt/sources.list.d/playonlinux.list
#apt-get update
#apt-get install playonlinux -y

#http://www.bendangelo.me/install/2014/10/29/installing-photoshop-cs6-on-ubuntu.html

echo ${green}.................................................................................................${reset}
echo ${green}.............................................. DONE .............................................${reset}
echo ${green}.................................................................................................${reset}

