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

### Install LEMP (nginx + MySQL + PHPMyAdmin) and configure it
echo ${GREEN}.............. Installing and Configuring LEMP: Linux + nginx + MySQL + phpmyadmin ..............${RESET}
# Uninstall/Clear possible extra programs
apt-get purge -y apache2* php5* mysql*
dpkg -l | grep apache*
dpkg -l | grep php5*
dpkg -l | grep mysql*
apt-get autoremove -y
# Set up variables:
# site folder path
SITE_PATH="/usr/share/nginx/html"
# server name
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
echo ${GREEN}.......................................... Installing PHP .......................................${RESET}
echo -ne '\n' | add-apt-repository ppa:ondrej/php5-5.6
apt-get update && apt-get upgrade -y
apt-get install php5 -y
apt-get install php5-fpm php-mbstring php-pdo php5-mysql php5-gd php-intl php-opcache php-devel php-xml php-apc php5-mcrypt php5-xdebug -y
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
sed -i '/^listen.allowed_clients/c;listen.allowed_clients =' ${WWW_CONF}
sed -i '/^;catch_workers_output/ccatch_workers_output = yes' ${WWW_CONF}
# Create phpinfo() file
cat > ${SITE_PATH}/info.php << EOF
<?php phpinfo(); ?>
EOF
### Install nginx
echo ${GREEN}.......................................... Installing Nginx .....................................${RESET}
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
echo ${GREEN}................................. Installing MySQL & phpmyadmin .................................${RESET}
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
echo ${GREEN}.............................................. Done .............................................${RESET}

