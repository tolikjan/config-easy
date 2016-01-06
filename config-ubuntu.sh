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
nginx_conf="/etc/nginx/nginx.conf"
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
#
# Install nginx
#
apt-get update
apt-get install nginx -y
service nginx start
# Set password for root account
echo "mysql-server mysql-server/root_password password "${mysql_root_password} | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password "${mysql_root_password} | debconf-set-selections
# Install MySQL-server
apt-get install mysql-server php5-mysql -y
#
# Install php5 and related modules
#
echo ${green}.................................................................................................${reset}
echo ${green}........................................ Installing PHP .........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
php_config_file="/etc/php5/fpm/php.ini"
apt-get install php5 php5-common php5-cli php5-fpm php5-gd php5-xdebug -y
# Stop services
service nginx stop
service php5-fpm stop
# Change configuration for better security and convenience
sed -i 's/^error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g' ${php_config_file1}
sed -i 's/^html_errors = Off/html_errors = On/g' ${php_config_file1}
sed -i 's/^display_startup_errors = Off/display_startup_errors = On/g' ${php_config_file1}
sed -i 's/^display_errors = Off/display_errors = On/g' ${php_config_file1}
sed -i 's/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${php_config_file1}
# Change configuration if you planing to load big files
sed -i 's/^post_max_size = 8M/post_max_size = 200M/g' ${php_config_file1}
sed -i 's/^upload_max_filesize = 2M/upload_max_filesize = 200M/g' ${php_config_file1}
# Change configuration www.conf
sed -i 's/^;security.limit_extensions = .php .php3 .php4 .php5/security.limit_extensions = .php .php3 .php4 .php5/g' ${www_conf}
sed -i 's/^;listen.mode = 0660/listen.mode = 0660/g' ${www_conf}
sed -i 's/^listen =  127.0.0.1:9000/listen = /var/run/php5-fpm.sock/g' ${www_conf}
# Start services
service nginx start
service php5-fpm start
# Remove default settings for nginx
cp ${default_nginx_conf} ${default_nginx_conf}.backup
# Configure nginx for http://localhost/
cat > ${default_nginx_conf} << EOF
server {
    listen   127.0.0.1:8080; ## listen for ipv4; 
    listen   localhost:8080 ipv6only=on; ## listen for ipv6

    root ${site_path};
    index index.php index.html index.htm;

    # Make site accessible from http://localhost/ to all projects
    server_name ${server_name};

    location / {
        # First attempt to serve request as file, then
        # as directory, then fall back to displaying a 404.
        try_files \$uri \$uri/ /index.html;
        expires max;
        autoindex on;
    }

     location ~* ^.+\\.(cur|js|jpe?g|ico|gif|png|svg|css|mp3|ogg|mpe?g|avi|zip|gz|bz2?|rar|swf)\$ {
                expires 7d;
                access_log off;
                tcp_nodelay off;
                open_file_cache max=3000 inactive=120s;
                open_file_cache_valid 45s;
                open_file_cache_min_uses 2;
                open_file_cache_errors off;
        }

    # ImageCache
    location ~ ^/imagecache/ {
        try_files \$uri @rewrite;
    }
    
    location @rewrite {
                rewrite ^/(.*)\$ /index.php?q=\$1;
        }
    
    ## Include phpmyadmin location here
    include phpmyadmin.conf;
    
    location /doc/ {
        alias /usr/share/doc/;
        allow 127.0.0.1;
        allow ::1;
        deny all;
    }

    # redirect server error pages to the static page /50x.html
    #
    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root errors/;
    }

    # pass the PHP scripts to FastCGI server
    #
    location ~ \\.php\$ {
    
    #   # For Micro Caching
    #   include microcache.conf;

    #   # With php5-cgi alone:
    #   fastcgi_pass 127.0.0.1:9000;
    #   # With php5-fpm:
        fastcgi_pass unix:/tmp/php5-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root\$fastcgi_script_name;
        include fastcgi_params;
        include fastcgi_caches;
    }
    
    ## Disallow access to .git directory: return 404 as not to disclose information.
    location ^~ /.git {
        return 404;
    }
    
    ## Support for favicon. Return an 1x1 transparent GIF if it doesn't exist.
    location = /favicon.ico {
        expires 30d;
        try_files /favicon.ico @empty;
    }

    ## Return an in memory 1x1 transparent GIF.
    location @empty {
        expires 30d;
        empty_gif;
    }

    ## Any other attempt to access PHP files returns a 404.
    location ~* ^.+\\.php$ {
        return 404;
    }

}
EOF
# Configure nginx.conf
cat > ${nginx_conf} << EOF
user www-data;
master_process on;
worker_processes 4;
pid /var/run/nginx.pid;

events {
    worker_connections  1024;
     multi_accept on;
}

http {
    
    ##
    # Include Nginx Basic Settings
    ##
    
    include basic_settings;
    
    ##
    # Include Client Settings and Timeouts
    ##
    
    include client_settings;

    ##
    # Include Nginx Logging Settings
    ##

    include log_settings;

    ##
    # Include Nginx Gzip Settings
    ##

    include gzip_settings;

    ##
    # Virtual Host Configs
    ##
    
    include sites-enabled/*;
}
EOF
# Configure basic_settings
cat > ${basic_settings} << EOF
##
# Nginx Basic Settings
##

sendfile on;
tcp_nopush on;
tcp_nodelay on;
keepalive_timeout 10;
types_hash_max_size 2048;
# server_tokens on;
server_tokens on;

# server_names_hash_bucket_size 64;
server_names_hash_bucket_size 64;

# Mime types
include mime.types;
default_type application/octet-stream;
EOF
# Configure client_settings
cat > ${client_settings} << EOF
## Timeouts.
client_body_timeout                 60;
client_header_timeout               60;
keepalive_timeout                10 10;
send_timeout                        60;

## Body Size
client_max_body_size              128M;

## Reset lingering timed out connections. Deflect DDoS.
reset_timedout_connection           on;

## Buffer Size
client_header_buffer_size           1k;
large_client_header_buffers       4 4k;
EOF
# Configure fastcgi_caches
cat > ${fastcgi_caches} << EOF
# Bypass cache if flag is set
        fastcgi_no_cache            \$no_cache;
        fastcgi_cache_bypass        \$no_cache;
        fastcgi_cache               microcache;
        fastcgi_cache_key           \$server_name|\$request_uri;
        fastcgi_cache_valid         404 30m;
        fastcgi_cache_valid         200 10s;
        fastcgi_max_temp_file_size  1M;
        fastcgi_cache_use_stale     updating;
        fastcgi_pass_header         Set-Cookie;
        fastcgi_pass_header         Cookie;
        fastcgi_ignore_headers      Cache-Control Expires Set-Cookie;
EOF
# Configure fastcgi_params
cat > ${fastcgi_params} << EOF
fastcgi_param   QUERY_STRING        \$query_string;
fastcgi_param   REQUEST_METHOD      \$request_method;
fastcgi_param   CONTENT_TYPE        \$content_type;
fastcgi_param   CONTENT_LENGTH      \$content_length;

fastcgi_param   SCRIPT_FILENAME     \$request_filename;
fastcgi_param   SCRIPT_NAME         \$fastcgi_script_name;
fastcgi_param   REQUEST_URI         \$request_uri;
fastcgi_param   DOCUMENT_URI        \$document_uri;
fastcgi_param   DOCUMENT_ROOT       \$document_root;
fastcgi_param   SERVER_PROTOCOL     \$server_protocol;

fastcgi_param   GATEWAY_INTERFACE   CGI/1.1;
fastcgi_param   SERVER_SOFTWARE     nginx/\$nginx_version;

fastcgi_param   REMOTE_ADDR         \$remote_addr;
fastcgi_param   REMOTE_PORT         \$remote_port;
fastcgi_param   SERVER_ADDR         \$server_addr;
fastcgi_param   SERVER_PORT         \$server_port;
fastcgi_param   SERVER_NAME         \$server_name;

fastcgi_param   HTTPS               \$https;

# PHP only, required if PHP was built with --enable-force-cgi-redirect
fastcgi_param   REDIRECT_STATUS     200;
EOF
# Configure gzip_settings
cat > ${gzip_settings} << EOF
##
# Gzip Settings
##
gzip  on;
gzip_buffers 16 8k;
gzip_comp_level 5;
gzip_http_version 1.1;
gzip_min_length 10;
gzip_types text/plain text/css image/png image/gif image/jpeg application/x-javascript text/xml application/xml application/xml+rss text/javascript image/x-icon;
gzip_vary on;
gzip_static on;
gzip_proxied any;
gzip_disable "MSIE [1-6]\.";
EOF
# Configure log_settings
#cat > ${log_settings} << EOF
##
# Nginx Logging Settings
##

#access_log /var/log/nginx/access.log;
#error_log /var/log/nginx/error.log;
#EOF
# Configure mime.types
#cat > ${mime.types} << EOF
# Mime Types
#types {
#    text/html                               html htm shtml;
#    text/css                                css;
#    text/xml                                xml rss;
#    image/gif                               gif;
#    image/jpeg                              jpeg jpg;
#    application/x-javascript                js;
#    application/atom+xml                    atom;
#
#    text/mathml                             mml;
#    text/plain                              txt;
#    text/vnd.sun.j2me.app-descriptor        jad;
#    text/vnd.wap.wml                        wml;
#    text/x-component                        htc;

#    image/png                               png;
#    image/tiff                              tif tiff;
#    image/vnd.wap.wbmp                      wbmp;
#    image/x-icon                            ico;
#    image/x-jng                             jng;
#    image/x-ms-bmp                          bmp;
#    image/svg+xml                           svg svgz;

#    application/java-archive                jar war ear;
#    application/json                        json;
#    application/mac-binhex40                hqx;
#    application/msword                      doc;
#    application/pdf                         pdf;
#    application/postscript                  ps eps ai;
#    application/rtf                         rtf;
#    application/vnd.ms-excel                xls;
#    application/vnd.ms-powerpoint           ppt;
#    application/vnd.wap.wmlc                wmlc;
#    application/vnd.google-earth.kml+xml    kml;
#    application/vnd.google-earth.kmz        kmz;
#    application/x-7z-compressed             7z;
#    application/x-cocoa                     cco;
#    application/x-java-archive-diff         jardiff;
#    application/x-java-jnlp-file            jnlp;
#    application/x-makeself                  run;
#    application/x-perl                      pl pm;
#    application/x-pilot                     prc pdb;
#    application/x-rar-compressed            rar;
#    application/x-redhat-package-manager    rpm;
#    application/x-sea                       sea;
#    application/x-shockwave-flash           swf;
#    application/x-stuffit                   sit;
#    application/x-tcl                       tcl tk;
#    application/x-x509-ca-cert              der pem crt;
#    application/x-xpinstall                 xpi;
#    application/xhtml+xml                   xhtml;
#    application/zip                         zip;

#    application/octet-stream                bin exe dll;
#    application/octet-stream                deb;
#    application/octet-stream                dmg;
#    application/octet-stream                eot;
#    application/octet-stream                iso img;
#    application/octet-stream                msi msp msm;
#    application/ogg                         ogx;

#    audio/midi                              mid midi kar;
#    audio/mpeg                              mpga mpega mp2 mp3 m4a;
#    audio/ogg                               oga ogg spx;
#    audio/x-realaudio                       ra;
#    audio/webm                              weba;

#    video/3gpp                              3gpp 3gp;
#    video/mp4                               mp4;
#    video/mpeg                              mpeg mpg mpe;
#    video/ogg                               ogv;
#    video/quicktime                         mov;
#    video/webm                              webm;
#    video/x-flv                             flv;
#    video/x-mng                             mng;
#    video/x-ms-asf                          asx asf;
#    video/x-ms-wmv                          wmv;
#    video/x-msvideo                         avi;
#}
#EOF
# Give permissions for log file
chmod 777 -R /var/log/nginx/access.log
chmod 777 -R /var/log/nginx/error.log
# Create phpinfo() file
cat > ${site_path}/info.php << EOF
<?php
phpinfo();
?>
EOF
chmod 777 -R ${site_path}
# xdebug configuring in php.ini file
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
# xdebug configuring in php.ini file
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
echo "127.0.0.1         ${server_name}" >> /etc/hosts
# Restart services
service mysql restart
service nginx restart
service php5-fpm restart
# Install PhpMyAdmin
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-user string root" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password "${mysql_root_password} | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password "${phpmyadmin_root_password} |debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password "${phpmyadmin_root_password} | debconf-set-selections
apt-get install phpmyadmin -y
# Configure nginx.conf
#cat > ${phpmyadmin.conf} << EOF
# PhpMyAdmin configuration

#location /phpmyadmin {
#       root /usr/share/;
#       index index.php index.html index.htm;
#       location ~ ^/phpmyadmin/(.+\\.php)\$ {
#               #try_files \$uri =404;
#               root /usr/share/;
#               #fastcgi_pass 127.0.0.1:9000;
#               fastcgi_pass unix:/tmp/php5-fpm.sock;
#               fastcgi_index index.php;
#               fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
#               include fastcgi_params;
#       }
#       location ~* ^/phpmyadmin/(.+\\.(jpg|jpeg|gif|css|png|js|ico|html|xml|txt))\$ {
#               root /usr/share/;
#       }
#}
#location /phpMyAdmin {
#       rewrite ^/* /phpmyadmin last;
#}
#EOF
# Create a symbolic link between phpMyAdmin and website root directory
ln -s /usr/share/phpmyadmin/ ${site_path}
# Disable by default, as this will add to all VirtualHosts; instead, add the following to an Apache VirtualHost:
#echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
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
EOF
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

