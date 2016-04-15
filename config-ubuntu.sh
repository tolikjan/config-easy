#!/bin/bash

# This script will be helpful after reinstalling you operating system
# Tested on Ubuntu 14.04.4 64x

# For testing, I used vagrant-box
# https://sourceforge.net/projects/osboxes/files/vms/vbox/Ubuntu/14.04/14.04.4/Ubuntu_14.04.4-64bit.7z/download
# with next credentials:
#ROOT_USER="osboxes"
#ROOT_PASS="osboxes.org"

# Coloured variables for script
RESET=`tput sgr0`
GREEN=`tput setaf 2`
RED=`tput setaf 1`
# Coloured variables for y/N prompts
RESTORE=$(echo '\033[0m')
YELLOW=$(echo '\033[00;33m')

WHOAMI="$(id -u -n)"
# Entering root user
echo "Type the ROOT USER that you have on this PC, followed by [ENTER]:"
read ROOT_USER
if [ "$ROOT_USER" == "$WHOAMI" ]; then
    # Entering root password
    echo "Type the ROOT PASSWORD that you have on this PC, followed by [ENTER]:"
    read ROOT_PASS
else
    echo "You typed incorrect username with root privileges. The script will be aborted"
    exit
fi

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
read -r -p "${YELLOW}Do you want to install Google Chrome Browser? [Y/n] ${RESTORE}" CHROME
case $CHROME in
    [yY][eE][sS]|[yY])
        echo ${GREEN}................................... Installing Google Chrome ....................................${RESET}
        # Get deb. package, unpack and remove it after installing
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        dpkg -i ./google-chrome*.deb
        apt-get install -f -y
        rm -rf google-chrome*.deb
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}.............................. Omitting Google Chrome installation ..............................${RESET}
        ;;
esac
### Install xclip tool — for easily copying files/ssh keys via terminal
read -r -p "${YELLOW}Do you want to install xclip? [Y/n] ${RESTORE}" XCLIP
case $XCLIP in
    [yY][eE][sS]|[yY])
        echo ${GREEN}........................................ Installing xclip .......................................${RESET}
        apt-get install xclip -y
        # Example for copy the contents of the id_rsa.pub file to your clipboard with command below
        #xclip -sel clip < ~/.ssh/id_rsa.pub
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}.................................. Omitting xclip installation ..................................${RESET}
        ;;
esac
### Install ccsm http://wiki.compiz.org/CCSM http://help.ubuntu.ru/wiki/ccsm
read -r -p "${YELLOW}Do you want to install ccsm? [Y/n] ${RESTORE}" CCSM
case $CCSM in
    [yY][eE][sS]|[yY])
        echo ${GREEN}........................................ Installing ccsm ........................................${RESET}
        apt-get install compizconfig-settings-manager -y
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}.................................. Omitting ccsm installation ...................................${RESET}
        ;;
esac
### Install gparted http://gparted.org/
read -r -p "${YELLOW}Do you want to install Gparted? [Y/n] ${RESTORE}" GPARTED
case $GPARTED in
    [yY][eE][sS]|[yY])
        echo ${GREEN}...................................... Installing gparted .......................................${RESET}
        apt-get install gparted -y
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}................................ Omitting gparted installation ..................................${RESET}
        ;;
esac
### Install Flash Player for Firefox
read -r -p "${YELLOW}Do you want to install Flash Player for Firefox Browser? [Y/n] ${RESTORE}" FFFP
case $FFFP in
    [yY][eE][sS]|[yY])
        echo ${GREEN}.................................... Installing Flash Player ....................................${RESET}
        apt-get install flashplugin-installer -y
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}............................. Omitting Flash Player installation ................................${RESET}
        ;;
esac
### Install Tweak Tool for Ubuntu additional settings https://launchpad.net/unity-tweak-tool
# NOTE: Do not use this for Ubuntu Gnome, cause it already enabled there
read -r -p "${YELLOW}Do you want to install Tweak Tool? [Y/n] ${RESTORE}" TWEAK
case $TWEAK in
    [yY][eE][sS]|[yY])
        echo ${GREEN}..................................... Installing Tweak Tool .....................................${RESET}
        apt-get install unity-tweak-tool
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}.............................. Omitting Tweak Tool installation .................................${RESET}
        ;;
esac
### Install utilities for archive manager with 7z and rar support
read -r -p "${YELLOW}Do you want to add unrar and 7z support for archive manager? [Y/n] ${RESTORE}" UNRAR
case $UNRAR in
    [yY][eE][sS]|[yY])
        echo ${GREEN}.................................... Installing 7z and Unrar ....................................${RESET}
        apt-get install p7zip-full -y
        apt-get install unrar -y
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}............................. Omitting 7z and Unrar installation ................................${RESET}
        ;;
esac
### Install Skype http://www.skype.com/
read -r -p "${YELLOW}Do you want to install Skype? [Y/n] ${RESTORE}" SKYPE
case $SKYPE in
    [yY][eE][sS]|[yY])
        # Install dependencies for Skype
        apt-get install -y sni-qt:i386 libdbusmenu-qt2:i386 libqt4-dbus:i386 libxss1:i386
        apt-get install -y libgtk2.0-0:i386 gtk2-engines:i386 libgconf-2-4:i386
        add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
        # Install Skype
        apt-get update
        apt-get install skype -y
        # Install sound plugins for fixing problems with sound for Ubuntu
        #apt-get install libasound2-plugins:i386 -y
        # TODO : Check whether Skype works on Ubuntu with this settings
        apt-get install libpulse0:i386 -y
        ;;
    *)
        echo ${RED}................................. Omitting Skype installation ...................................${RESET}
        ;;
esac
### Install Tor Browser https://www.torproject.org/
read -r -p "${YELLOW}Do you want to install Tor Browser? [Y/n] ${RESTORE}" TOR
case $TOR in
    [yY][eE][sS]|[yY])
        echo ${GREEN}.................................... Installing Tor Browser .....................................${RESET}
        echo -ne '\n' | add-apt-repository ppa:webupd8team/tor-browser
        apt-get update
        apt-get install tor-browser -y
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}............................. Omitting Tor Browser installation .................................${RESET}
        ;;
esac
### Install Telegram messenger https://telegram.org/
read -r -p "${YELLOW}Do you want to install Telegram messenger? [Y/n] ${RESTORE}" TELEGRAM
case $TELEGRAM in
    [yY][eE][sS]|[yY])
        echo ${GREEN}...................................... Installing Telegram ......................................${RESET}
        echo -ne '\n' | add-apt-repository ppa:atareao/telegram
        apt-get update
        apt-get install telegram -y
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}............................... Omitting Telegram installation ..................................${RESET}
        ;;
esac
### Install Shutter http://shutter-project.org/
read -r -p "${YELLOW}Do you want to install Shutter? [Y/n] ${RESTORE}" SHUTTER
case $SHUTTER in
    [yY][eE][sS]|[yY])
        echo ${GREEN}...................................... Installing Shutter .......................................${RESET}
        echo -ne '\n' | add-apt-repository ppa:shutter/ppa
        apt-get install shutter -y
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}............................... Omitting Shutter installation ...................................${RESET}
        ;;
esac
### Install SSH Server http://www.openssh.com/
read -r -p "${YELLOW}Do you want to install SSH Server? [Y/n] ${RESTORE}" SSH
case $SSH in
    [yY][eE][sS]|[yY])
        echo ${GREEN}..................................... Installing SSH Server .....................................${RESET}
        apt-get update
        apt-get install openssh-client -y
        apt-get install openssh-server -y
        mkdir ~/.ssh
        chmod 777 -R ~/.ssh/
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}................................. Omitting SSH installation .....................................${RESET}
        ;;
esac
### Install Git https://git-scm.com/
read -r -p "${YELLOW}Do you want to install Git (with tig tool)? [Y/n] ${RESTORE}" GIT
case $GIT in
    [yY][eE][sS]|[yY])
        echo ${GREEN}........................................ Installing Git .........................................${RESET}
        apt-get update
        apt-get install git -y
        # tig — text-mode interface for git http://jonas.nitro.dk/tig/manual.html
        apt-get install tig -y
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}.................................. Omitting Git installation ....................................${RESET}
        ;;
esac
### Install Selenium Server http://www.seleniumhq.org/
read -r -p "${YELLOW}Do you want to install Selenium Standalone Server? [Y/n] ${RESTORE}" SELENIUM
case $SELENIUM in
    [yY][eE][sS]|[yY])
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
        #DISPLAY=:1 xvfb-run java -jar ~/selenium/selenium-server-standalone-2.53.0.jar
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
        ;;
    *)
        echo ${RED}............................... Omitting Selenium installation ..................................${RESET}
        ;;
esac
### Install LAMP (Apache2 + MySQL + PHPMyAdmin) and configure it
read -r -p "${YELLOW}Do you want to install LAMP Stack? [Y/n] ${RESTORE}" LAMP
case $LAMP in
    [yY][eE][sS]|[yY])
        echo ${GREEN}............................. Installing and configuring LAMP Server ............................${RESET}
        # Site's folder path variable
        SITE_PATH="/var/www/html/"
        # mysql variables
        MYSQL_CONFIG_FILE="/etc/mysql/my.cnf"
        MYSQL_ROOT_USER="root"
        MYSQL_ROOT_PASS="root"
        # PHPMyAdmin
        PHPMYADMIN_PASS="root"
        # Check whether Nginx installed and remove it
        OUTPUT=$(/etc/init.d/nginx status)
        if [ "$OUTPUT" = " * nginx is running" ]; then
          apt-get purge nginx nginx-common -y
          rm -rf /etc/nginx
          sudo apt-get autoremove -y
        else
          echo "Nginx is not installed"
        fi
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
            echo "xdebug.profiler_enable=1" >> ${INI}
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
        ;;
    *)
        echo ${RED}................................. Omitting LAMP installation ....................................${RESET}
        # Add php 5.6 repo and install it
        echo -ne '\n' | add-apt-repository ppa:ondrej/php5-5.6
        apt-get update && apt-get upgrade -y
        # Install php-modules
        apt-get install php5 php-pear php5-cli php5-curl- y
        ;;
esac
### Install Composer https://getcomposer.org/
read -r -p "${YELLOW}Do you want to install Composer? [Y/n] ${RESTORE}" COMPOSER
case $COMPOSER in
    [yY][eE][sS]|[yY])
        echo ${GREEN}...................................... Installing Composer ......................................${RESET}
        apt-get update
        apt-get install php5-curl -y
        apt-get install curl php5-cli git -y
        curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
        chmod 777 -R ~/.composer/n
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}............................... Omitting Composer installation ..................................${RESET}
        ;;
esac

### Install Drush — command line shell and Unix scripting interface for Drupal — http://www.drush.org/en/master/
# IMPORTANT! You need to install Composer first
read -r -p "${YELLOW}Do you want to install Drush? [Y/n] ${RESTORE}" DRUSH
case $DRUSH in
    [yY][eE][sS]|[yY])
        echo ${GREEN}........................................ Installing Drush .......................................${RESET}
        curl -sS https://getcomposer.org/installer | php
        mv composer.phar /usr/local/bin/composer
        export PATH="$HOME/.composer/vendor/bin:$PATH"
        composer global require drush/drush:8.*
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}................................ Omitting Drush installation ....................................${RESET}
        ;;
esac
### Install VirtualBox https://www.virtualbox.org/
read -r -p "${YELLOW}Do you want to install VirtualBox? [Y/n] ${RESTORE}" VIRTUALBOX
case $VIRTUALBOX in
    [yY][eE][sS]|[yY])
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
        ;;
    *)
        echo ${RED}............................. Omitting Virtual Box installation .................................${RESET}
        ;;
esac
### Install Vagrant https://www.vagrantup.com/docs/
read -r -p "${YELLOW}Do you want to install Vagrant? [Y/n] ${RESTORE}" VAGRANT
case $VAGRANT in
    [yY][eE][sS]|[yY])
        echo ${GREEN}....................................... Installing Vagrant ......................................${RESET}
        # Get deb, unpack it and remove after installing
        wget https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
        dpkg -i vagrant*.deb
        apt-get install vagrant -y
        apt-get install -f -y
        rm -rf vagrant*.deb
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}............................... Omitting Vagrant installation ...................................${RESET}
        ;;
esac
### Install Docker https://www.docker.com/
read -r -p "${YELLOW}Do you want to install Docker? [Y/n] ${RESTORE}" DOCKER
case $DOCKER in
    [yY][eE][sS]|[yY])
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
        # Add user to docker group
        usermod -aG docker ${ROOT_USER}
        # Add permission for docker
        chmod o+rw /var/run/docker.sock
        # Restart Docker
        service docker restart
        # NOTE: You need to restart you system too after step above
        # Drupal 8 Docker image — https://github.com/skilld-labs/docker-php
        # Latest Drupal 7 Docker image — https://github.com/wadmiraal/docker-drupal
        # Example of docker-run command(just uncomment it and execute via Terminal):
        #docker run -d -p 8080:80 -p 8022:22 -t wadmiraal/drupal:7
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}............................... Omitting Docker installation ....................................${RESET}
        ;;
esac
### Install SublimeText 3 https://www.sublimetext.com/3
read -r -p "${YELLOW}Do you want to install SublimeText 3? [Y/n] ${RESTORE}" SUBLIME
case $SUBLIME in
    [yY][eE][sS]|[yY])
        echo ${GREEN}.................................... Installing SublimeText3 ....................................${RESET}
        echo -ne '\n' | add-apt-repository ppa:webupd8team/sublime-text-3
        apt-get update
        apt-get install sublime-text-installer -y
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}............................. Omitting SublimeText3 installation ................................${RESET}
        ;;
esac
### Install HipChat https://www.hipchat.com/
read -r -p "${YELLOW}Do you want to install HipChat? [Y/n] ${RESTORE}" HIPCHAT
case $HIPCHAT in
    [yY][eE][sS]|[yY])
        echo ${GREEN}...................................... Installing HipChat .......................................${RESET}
        echo ${ROOT_PASS} | sudo su
        echo "deb http://downloads.hipchat.com/linux/apt stable main" > /etc/apt/sources.list.d/atlassian-hipchat.list
        wget -O - https://www.hipchat.com/keys/hipchat-linux.key | apt-key add -
        apt-get update
        apt-get install hipchat
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}................................ Omitting HipChat installation ..................................${RESET}
        ;;
esac
### Install PhpStorm 2016 — https://www.jetbrains.com/phpstorm/download/download-thanks.html?platform=linux
read -r -p "${YELLOW}Do you want to install PHPStorm 2016? [Y/n] ${RESTORE}" PHPSTORM
case $PHPSTORM in
    [yY][eE][sS]|[yY])
        echo ${GREEN}............................. Installing and Configuring PHPStopm10 .............................${RESET}
        wget http://download-cf.jetbrains.com/webide/PhpStorm-2016.1.tar.gz
        tar -xvf PhpStorm-2016.1.tar.gz
        cd PhpStorm-*/bin/
        sudo su -c "./phpstorm.sh || TRUE" -s /bin/sh ${ROOT_USER}
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ### Install Drupal code sniffer for phpStorm
        # https://www.drupal.org/node/1419988
        # phpcs source path — /home/your-user/.composer/vendor/bin/phpcs
        read -r -p "${YELLOW}Do you want to install Drupal Code Sniffer for PHPStorm? [Y/n] ${RESTORE}" CODESNIFFER
        case $CODESNIFFER in
            [yY][eE][sS]|[yY])
                echo ${GREEN}............................ Installing Drupal Code Sniffer .............................${RESET}
                composer global require drupal/coder
                composer global update drupal/coder --prefer-source
                export PATH="$PATH:$HOME/.composer/vendor/bin"
                phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer
                echo ${GREEN}.............................................. Done .............................................${RESET}
                ;;
            *)
                echo ${RED}.............................. Omitting Codesniffer installation ................................${RESET}
                ;;
        esac
        ;;
    *)
        echo ${RED}.............................. Omitting PHPStopm10 installation .................................${RESET}
        ;;
esac
### Restarting your machine
read -r -p "${YELLOW}Do you want to restart your PC? [Y/n] ${RESTORE}" RESTART
case $RESTART in
    [yY][eE][sS]|[yY])
        echo ${GREEN}............................................ Restart ............................................${RESET}
        shutdown -r now
        echo ${GREEN}.............................................. Done .............................................${RESET}
        ;;
    *)
        echo ${RED}.......................... You should restart your system manually ..............................${RESET}
        ;;
esac
echo ${GREEN}............................. Programs were installed successfully! .............................${RESET}
