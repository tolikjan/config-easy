# config-easy

You could use following shell script for auto installation all needed 
programs after OS reinstall.
You could choose which programs your want to install. Choice mode 
will be running after script start.
 
Please, do not chose "LEMP" and "LAMP" options in the same time!

### Clone Git Repo:
1) install `git` if it not installed yet:

    $ sudo apt-get install git -y 

2) go to chosen folder in Terminal:

    $ cd /path/to/folder
    
3) clone this GitHub Repo with command (use `sudo` if you in protected folder):

    $ git clone https://github.com/tolikjan/config-easy/tree/develop-t.git

### Usage:
Start shell with commands below (don't forget about `sudo`):

    $ cd /path/to/folder/config-easy
    $ sudo sh main-script.sh

### Include:
- Google Chrome (https://www.google.com/chrome/)
- xclip — for copy files via terminal
- CCSM (http://wiki.compiz.org/CCSM http://help.ubuntu.ru/wiki/ccsm)
- Gparted (http://gparted.org/)
- Flash player for FireFox Browser
- Tweak Tool (https://launchpad.net/unity-tweak-tool)
- 7z and Unrar — for work with .rar and .zip archives
- Skype (http://www.skype.com/en/)
- Tor Browser (https://www.torproject.org/)
- Telegram Messenger (https://telegram.org/)
- Shutter (http://shutter-project.org/)
- SSH Server (http://www.openssh.com/)
- ONGOING —> Code Sniffers for Drupal (https://www.drupal.org/node/1419988)
- Selenium Standalone Server (http://www.seleniumhq.org/)
- PHP 5.6 (http://php.net/)
- LEMP Server (Linux + nginx + MySQL + phpmyadmin)
- Composer (https://getcomposer.org/)
- ONGOING —> LAMP Server (Linux + Apache2 + MySQL + phpmyadmin)
- VirtualBox (https://www.virtualbox.org/)
- Vagrant (https://www.vagrantup.com/docs/)
- ONGOING —> Docker (https://www.docker.com/)
- SublimeText 3 (https://www.sublimetext.com/3)
- PHPStopm 10 (https://www.jetbrains.com/phpstorm/whatsnew/)
- HipChat (https://www.hipchat.com/)

Checked/tested on Ubuntu 14.04.4 LTS 64x
