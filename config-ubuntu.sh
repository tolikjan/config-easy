#!/bin/bash

# This script will be helpful after reinstalling you operating system
# Tested on Ubuntu 14.04.3 64x

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
# Install archive manager with 7z support
#
echo ${green}.................................................................................................${reset}
echo ${green}......................................... Installing 7z .........................................${reset}
echo ${green}.................................................................................................${reset}
sleep 5
apt-get install p7zip-full -y
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
apt-get install tor-browser
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
proxy_conf="/etc/nginx/proxy.conf"
fastcgi_conf="/etc/nginx/fastcgi.conf"
mime_types="conf/mime.types"
fastcgi_server_name="domain1.com"
reverse_server_name="domain2.com"
server_name="big.server.com"
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
	user       root root;  ## Default: nobody
	worker_processes  4;  ## Default: 1
	error_log  logs/error.log;
	pid        logs/nginx.pid;
	worker_rlimit_nofile 8192;

	events {
  		worker_connections  4096;  ## Default: 1024
	}

	http {
  		include    ${mime_types};
  		include    ${proxy_conf};
  		include    ${fastcgi_conf};
  		index    index.html index.htm index.php;

  		default_type application/octet-stream;
  		log_format   main '$remote_addr - $remote_user [$time_local]  $status '
    		'"$request" $body_bytes_sent "$http_referer" '
    		'"$http_user_agent" "$http_x_forwarded_for"';
  		access_log   logs/access.log  main;
  		sendfile     on;
  		tcp_nopush   on;
  		server_names_hash_bucket_size 128; # this seems to be required for some vhosts

  		server { # php/fastcgi
    		listen       80;
    		server_name  ${fastcgi_server_name} www.${fastcgi_server_name};
    		access_log   logs/${fastcgi_server_name}.access.log  main;
    		root         html;

    		location ~ \.php$ {
      			fastcgi_pass   127.0.0.1:1025;
    		}
  		}

  		server { # simple reverse-proxy
    		listen       80;
    		server_name  ${reverse_server_name} www.${reverse_server_name};
    		access_log   logs/${reverse_server_name}.access.log  main;

    		# serve static files
    		location ~ ^/(images|javascript|js|css|flash|media|static)/  {
      			root    /var/www/html/${server_name}/htdocs;
      			expires 30d;
    		}

    		# pass requests for dynamic content to rails/turbogears/zope, et al
    		location / {
      			proxy_pass      http://127.0.0.1:8080;
    		}
  		}

  		upstream ${server_name} {
    		server 127.0.0.3:8000 weight=5;
    		server 127.0.0.3:8001 weight=5;
    		server 192.168.0.1:8000;
    		server 192.168.0.1:8001;
  		}

  		server { # simple load balancing
    		listen          80;
    		server_name     ${server_name};
    		access_log      logs/${server_name}.access.log main;

    		location / {
      			proxy_pass      http://${server_name};
    		}
  		}
	}
EOF
# Configure proxy conf.
cat > ${proxy_conf} << EOF
	proxy_redirect          off;
	proxy_set_header        Host            $host;
	proxy_set_header        X-Real-IP       $remote_addr;
	proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
	client_max_body_size    10m;
	client_body_buffer_size 128k;
	proxy_connect_timeout   90;
	proxy_send_timeout      90;
	proxy_read_timeout      90;
	proxy_buffers           32 4k;
EOF
# Configure fastcgi conf.
cat > ${fastcgi_conf} << EOF
	fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;
	fastcgi_param  QUERY_STRING       $query_string;
	fastcgi_param  REQUEST_METHOD     $request_method;
	fastcgi_param  CONTENT_TYPE       $content_type;
	fastcgi_param  CONTENT_LENGTH     $content_length;
	fastcgi_param  SCRIPT_NAME        $fastcgi_script_name;
	fastcgi_param  REQUEST_URI        $request_uri;
	fastcgi_param  DOCUMENT_URI       $document_uri;
	fastcgi_param  DOCUMENT_ROOT      $document_root;
	fastcgi_param  SERVER_PROTOCOL    $server_protocol;
	fastcgi_param  GATEWAY_INTERFACE  CGI/1.1;
	fastcgi_param  SERVER_SOFTWARE    nginx/$nginx_version;
	fastcgi_param  REMOTE_ADDR        $remote_addr;
	fastcgi_param  REMOTE_PORT        $remote_port;
	fastcgi_param  SERVER_ADDR        $server_addr;
	fastcgi_param  SERVER_PORT        $server_port;
	fastcgi_param  SERVER_NAME        $server_name;

	fastcgi_index  index.php;
EOF
# Configure types file
cat > ${mime_types} << EOF
	types {
  		text/html                             html htm shtml;
  		text/css                              css;
  		text/xml                              xml rss;
  		image/gif                             gif;
  		image/jpeg                            jpeg jpg;
  		application/x-javascript              js;
  		text/plain                            txt;
  		text/x-component                      htc;
  		text/mathml                           mml;
  		image/png                             png;
  		image/x-icon                          ico;
  		image/x-jng                           jng;
  		image/vnd.wap.wbmp                    wbmp;
  		application/java-archive              jar war ear;
  		application/mac-binhex40              hqx;
  		application/pdf                       pdf;
  		application/x-cocoa                   cco;
  		application/x-java-archive-diff       jardiff;
  		application/x-java-jnlp-file          jnlp;
  		application/x-makeself                run;
  		application/x-perl                    pl pm;
  		application/x-pilot                   prc pdb;
  		application/x-rar-compressed          rar;
  		application/x-redhat-package-manager  rpm;
  		application/x-sea                     sea;
  		application/x-shockwave-flash         swf;
  		application/x-stuffit                 sit;
  		application/x-tcl                     tcl tk;
  		application/x-x509-ca-cert            der pem crt;
  		application/x-xpinstall               xpi;
  		application/zip                       zip;
  		application/octet-stream              deb;
  		application/octet-stream              bin exe dll;
  		application/octet-stream              dmg;
  		application/octet-stream              eot;
  		application/octet-stream              iso img;
  		application/octet-stream              msi msp msm;
  		audio/mpeg                            mp3;
  		audio/x-realaudio                     ra;
  		video/mpeg                            mpeg mpg;
  		video/quicktime                       mov;
  		video/x-flv                           flv;
  		video/x-msvideo                       avi;
  		video/x-ms-wmv                        wmv;
  		video/x-ms-asf                        asx asf;
  		video/x-mng                           mng;
	}
EOF
# Restart nginx
service nginx restart
# Install Memcached
apt-get install memcached php5-memcached
service php5-fpm restart
service nginx restart







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

