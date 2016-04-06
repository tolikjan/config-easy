
#!/bin/bash

# This script will be helpful after reinstalling you operating system
# Tested on Ubuntu 14.04.4 64x
# For testing, I used vagrant-box
# https://sourceforge.net/projects/osboxes/files/vms/vbox/Ubuntu/14.04/14.04.4/Ubuntu_14.04.4-64bit.7z/download
# with next credentials:
ROOT_USER="osboxes"
ROOT_PASS="osboxes.org"
# Remove test credentials above with your own

# Coloured variables for script
RESET=`tput sgr0`
GREEN=`tput setaf 2`

### Update and Upgrade the system
echo ${GREEN}................................. Update and Upgrade the system .................................${RESET}
sleep 5
apt-get update && apt-get upgrade -y
# Disable guest session
echo "allow-guest=false" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
# Configuring system to allow more performance
# "vm.swappiness=7" — means that you system will start using swap, when RAM will be full for 93%
echo "vm.swappiness=7" >> /etc/sysctl.conf
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install Google Chrome https://www.google.com/chrome/
echo ${GREEN}................................... Installing Google Chrome ....................................${RESET}
# Get deb, unpack it and remove after installing
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i ./google-chrome*.deb
apt-get install -f -y
rm -rf google-chrome*.deb
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install xclip tool — for easily copying files/ssh keys via terminal
echo ${GREEN}........................................ Installing xclip .......................................${RESET}
apt-get install xclip -y
# Example for copy the contents of the id_rsa.pub file to your clipboard with command below
#xclip -sel clip < ~/.ssh/id_rsa.pub
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install ccsm http://wiki.compiz.org/CCSM http://help.ubuntu.ru/wiki/ccsm
echo ${GREEN}........................................ Installing ccsm ........................................${RESET}
apt-get install compizconfig-settings-manager -y
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install gparted http://gparted.org/
echo ${GREEN}...................................... Installing gparted .......................................${RESET}
apt-get install gparted -y
### Install Flash player for Firefox
echo ${GREEN}............................... Installing Firefox Flash Player .................................${RESET}
echo -ne '\n' | add-apt-repository ppa:nilarimogard/webupd8
apt-get update
apt-get install freshplayerplugin -y
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install Tweak Tools for Ubuntu additional settings
echo ${GREEN}.................................... Installing Tweak Tool ......................................${RESET}
apt-get install unity-tweak-tool
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install utilities for archive manager with 7z and rar support
echo ${GREEN}.............................. Installing 7z and Unrar utilities ................................${RESET}
apt-get install p7zip-full -y
apt-get install unrar -y
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install Skype http://www.skype.com/
echo ${GREEN}........................................ Installing Skype .......................................${RESET}
# Install dependencies for Skype
apt-get install -y sni-qt:i386 libdbusmenu-qt2:i386 libqt4-dbus:i386 libxss1:i386
apt-get install -y libgtk2.0-0:i386 gtk2-engines:i386 libgconf-2-4:i386
add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
# Install Skype
apt-get update
apt-get install skype -y
# Install sound plugins for fixing problems with sound for Ubuntu
apt-get install libasound2-plugins:i386 -y
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install Tor Browser https://www.torproject.org/
echo ${GREEN}.................................... Installing Tor Browser .....................................${RESET}
echo -ne '\n' | add-apt-repository ppa:webupd8team/tor-browser
apt-get update
apt-get install tor-browser -y
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install Telegram messenger https://telegram.org/
echo ${GREEN}...................................... Installing Telegram ......................................${RESET}
echo -ne '\n' | add-apt-repository ppa:atareao/telegram
apt-get update
apt-get install telegram -y
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install Shutter http://shutter-project.org/
echo ${GREEN}...................................... Installing Shutter .......................................${RESET}
echo -ne '\n' | add-apt-repository ppa:shutter/ppa
apt-get install shutter -y
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install SSH
echo ${GREEN}..................................... Installing SSH Server .....................................${RESET}
apt-get update
apt-get install openssh-client -y
apt-get install openssh-server -y
mkdir ~/.ssh
chmod 777 -R ~/.ssh/
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install Git
echo ${GREEN}......................................... Installing Git ........................................${RESET}
apt-get update
apt-get install git -y
apt-get install tig -y
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install Composer
echo ${GREEN}...................................... Installing Composer ......................................${RESET}
apt-get update
apt-get install php5-curl -y
apt-get install curl php5-cli git -y
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
chmod 777 -R ~/.composer/
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install Drush — command line shell and Unix scripting interface for Drupal — http://www.drush.org/en/master/
# IMPORTANT! You need to install Composer first
echo ${GREEN}........................................ Installing Drush .......................................${RESET}
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
export PATH="$HOME/.composer/vendor/bin:$PATH"
composer global require drush/drush:8.*
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install Code Sniffer
echo ${GREEN}................................... Installing Code Sniffer .....................................${RESET}
### Install code sniffer for phpStorm
# https://www.drupal.org/node/1419988
composer global require drupal/coder
composer global update drupal/coder --prefer-source
export PATH="$PATH:$HOME/.composer/vendor/bin"
phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install Selenium Server http://www.seleniumhq.org/
echo ${GREEN}.................................. Installing Selenium Server ...................................${RESET}
echo -ne '\n' | add-apt-repository ppa:webupd8team/java
apt-get update
# Create folder for Selenium
mkdir ~/selenium
cd ~/selenium
# Install xvfb - display server which implementing the X11 display server protocol
apt-get install xvfb -y
# Get Selenium and install headless Java runtime (you should check newest release on http://www.seleniumhq.org/download/)
wget http://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.0.jar
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
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install LAMP (Apache2 + MySQL + PHPMyAdmin) and configure it
echo ${GREEN}............................. Installing and configuring LAMP Server ............................${RESET}
# Site's folder path variable
SITE_PATH="/var/www/html/"
# mysql variables
MYSQL_CONFIG_FILE="/etc/mysql/my.cnf"
MYSQL_ROOT_USER="root"
MYSQL_ROOT_PASS="root"
# PHPMyAdmin
PHPMYADMIN_PASS="root"
# Install Apache2 and configure it
echo ${GREEN}....................................... Installing Apache2 ......................................${RESET}
# Add php 5.6 repo and install it
echo -ne '\n' | add-apt-repository ppa:ondrej/php5-5.6
apt-get update && apt-get upgrade -y
# Install Apache2 and all dependencies
apt-get install php5 apache2 libapache2-mod-php5 php5-mcrypt -y
a2enmod rewrite ssl
# Setting SSL for default site
apt-get install ssl-cert -y
a2ensite default-ssl
# Enable mod_rewrite
a2enmod rewrite
# Enable mod_ssl
a2enmod ssl
# Config servername
echo "ServerName localhost" >> /etc/apache2/conf-available/fqdn.conf
a2enconf fqdn
# Restart service
service apache2 restart
# Install mysql-server
echo ${GREEN}.................................... Installing MySQL Server ....................................${RESET}
# Set password for root account
echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASS" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASS" | debconf-set-selections
apt-get install mysql-server php5-mysql -y
# Allow connections to this server from outside
mysql -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASS} -e "GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY '$MYSQL_ROOT_PASS';"
mysql -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASS} -e "FLUSH PRIVILEGES;"
# Restart service
service mysql stop
service mysql start
# Install PHP 5.6 and all related modules
echo ${GREEN}........................................ Installing PHP .........................................${RESET}
# Install php-modules
apt-get install php-pear php5-cli php5-curl php5-gd php5-mcrypt php5-imagick php5-intl php5-memcached php5-memcache php5-json php5-xdebug -y
# Install PhpMyAdmin
echo ${GREEN}..................................... Installing PhpMyAdmin .....................................${RESET}
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-user string root" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOT_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_ROOT_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $PHPMYADMIN_PASS" | debconf-set-selections
apt-get install phpmyadmin -y
# Reload apache2 service
service apache2 reload
# php.ini configuration for displaying errors
for INI in $(find /etc -name 'php.ini')
do
    sed -i 's/^error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/' ${INI}
    sed -i 's/^display_errors = Off/display_errors = On/' ${INI}
    sed -i 's/^display_startup_errors = Off/display_startup_errors = On/' ${INI}
    sed -i 's/^html_errors = Off/html_errors = On/' ${INI}
    # Change configuration if you planing to load big files
    sed -i 's/^post_max_size = 8M/post_max_size = 200M/' ${INI}
    sed -i 's/^upload_max_filesize = 2M/upload_max_filesize = 200M/' ${INI}
done
# Set up xdebug variable
XDEBUG="$(find / -name "xdebug.so" 2> /dev/null)"
sleep 10
for INI in $(find /etc -name 'php.ini')
do
    echo "zend_extension=\"${XDEBUG}\"" >> ${INI}
    echo "memory_limit=-1" >> ${INI}
    echo "xdebug.profiler_enable = 1" >> ${INI}
    echo "xdebug.remote_autostart=1" >> ${INI}
    echo "xdebug.remote_enable=1" >> ${INI}
    echo "xdebug_enable=1" >> ${INI}
    echo "xdebug.remote_connect_back=1" >> ${INI}
    echo "xdebug.remote_port=9002" >> ${INI}
    echo "xdebug.idekey=PHP_STORM" >> ${INI}
    echo "xdebug.scream=0" >> ${INI}
    echo "xdebug.cli_color=1" >> ${INI}
    echo "xdebug.show_local_vars=1" >> ${INI}
    echo "xdebug.remote_connect_back = 1" >> ${INI}
    echo ";var_dump display" >> ${INI}
    echo "xdebug.var_display_max_depth = 5" >> ${INI}
    echo "xdebug.var_display_max_children = 256" >> ${INI}
    echo "xdebug.var_display_max_data = 1024" >> ${INI}
done
# Restart services
service mysql restart
service apache2 restart
# Add phpinfo file into the site directory
cat > ${SITE_PATH}/info.php << EOF
    <?php phpinfo(); ?>
EOF
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install VirtualBox https://www.virtualbox.org/
echo ${GREEN}.................................... Installing VirtualBox  .....................................${RESET}
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
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install Vagrant https://www.vagrantup.com/docs/
echo ${GREEN}....................................... Installing Vagrant ......................................${RESET}
# Get deb, unpack it and remove after installing
wget https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
dpkg -i vagrant*.deb
apt-get install vagrant -y
apt-get install -f -y
rm -rf vagrant*.deb
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install Docker and configure it — https://www.docker.com/
echo ${GREEN}............................... Installing and Configuring Docker ...............................${RESET}
# Tutorial — https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-14-04
# Install Docker
echo ${ROOT_PASS} | wget -qO- https://get.docker.com/ | sh
# Add your user to the docker group
usermod -aG docker $(whoami)
# Install python-pip as prerequisite for Docker Compose
apt-get install python-pip -y
pip install docker-compose
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install SublimeText 3 https://www.sublimetext.com/3
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
echo ${GREEN}.................................... Installing SublimeText 3 ...................................${RESET}
echo -ne '\n' | add-apt-repository ppa:webupd8team/sublime-text-3
apt-get update
apt-get install sublime-text-installer -y
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install HipChat https://www.hipchat.com/
echo ${GREEN}...................................... Installing HipChat .......................................${RESET}
echo ${ROOT_PASS} | sudo su
echo "deb http://downloads.hipchat.com/linux/apt stable main" > /etc/apt/sources.list.d/atlassian-hipchat.list
wget -O - https://www.hipchat.com/keys/hipchat-linux.key | apt-key add -
apt-get update
apt-get install hipchat
echo ${GREEN}.............................................. Done .............................................${RESET}
### Install PhpStorm 2016 https://www.jetbrains.com/phpstorm/download/
# Licence server here - https://бэкдор.рф/phpstorm-7-8-9-10-product-key/
echo ${GREEN}............................ Installing and Configuring PHPStopm2016 ............................${RESET}
wget http://download-cf.jetbrains.com/webide/PhpStorm-2016.1.tar.gz
tar -xvf PhpStorm-2016.1.tar.gz
cd PhpStorm-*/bin/
sudo su -c "./phpstorm.sh || TRUE" -s /bin/sh ${ROOT_USER}
echo ${GREEN}.............................................. Done .............................................${RESET}
echo ${GREEN}............................. Programs were installed successfully! .............................${RESET}
