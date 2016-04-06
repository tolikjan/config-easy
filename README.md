# old-script.sh

You could use following shell script for auto-installation (without Y/n prompts)
all needed programs after reinstalling your OS.

1) install `git` if it not installed yet

    $ sudo apt-get update
    $ sudo apt-get install git -y

2) go to chosen folder in Terminal:

    $ cd /path/to/folder
    
3) clone this GitHub Repo with command (use `sudo` if you in protected folder):

    $ git clone https://github.com/tolikjan/config-easy.git

4) *IMPORTANT!* change `ROOT_USER` and `ROOT_PASS` for yours in `config-ubuntu.sh`

5) start old shell script with commands below (don't forget about `sudo`):

    $ cd /path/to/folder/config-easy
    $ git checkout develop-t
    $ sudo sh old-script.sh

# config-ubuntu.sh

You could use following shell script for auto-installation all needed 
programs after reinstalling your OS.
You could choose which programs your want to install by yes/no prompts.
Choice-mode will be running after Updating/Upgrading steps.

### 1. Run script via cloning the Git Repo:
1) install `git` if it not installed yet

    $ sudo apt-get update
    $ sudo apt-get install git -y

2) go to chosen folder in Terminal:

    $ cd /path/to/folder
    
3) clone this GitHub Repo with command (use `sudo` if you in protected folder):

    $ git clone https://github.com/tolikjan/config-easy.git

4) *IMPORTANT!* change `ROOT_USER` and `ROOT_PASS` for yours in `config-ubuntu.sh`

5) start shell with commands below (don't forget about `sudo`):

    $ cd /path/to/folder/config-easy
    $ git checkout master
    $ sudo sh config-ubuntu.sh

### 2. Run script via copy/paste script into empty document and saving it on you PC:

1) create empty document

    $ cd /path/to/folder
    $ sudo nano name-you-script.sh

2) copy/paste this script and save changes in `nano` editor

    Ctrl+O
    Ctrl+X

3) change `ROOT_USER` and `ROOT_PASS` for yours in `name-you-script.sh`

4) start shell with commands below (don't forget about `sudo`):

    $ cd /path/to/folder
    $ sudo sh name-you-script.sh

NOTE: In the end of the script, last step will be PHPStorm installation.
You need to pass all steps with adding the License code and enabling new settings.

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
- Selenium Standalone Server (http://www.seleniumhq.org/)
- LAMP Server (Apache2 + MySQL + PHP 5.6 + phpmyadmin)
- ONGOING —> LEMP Server (Nginx + MySQL + PHP 5.6 + phpmyadmin)
- Composer (https://getcomposer.org/)
- VirtualBox (https://www.virtualbox.org/)
- Vagrant (https://www.vagrantup.com/docs/)
- Docker (https://www.docker.com/)
- SublimeText 3 (https://www.sublimetext.com/3)
- PHPStopm 10 (https://www.jetbrains.com/phpstorm/whatsnew/)
- Code Sniffers for Drupal (https://www.drupal.org/node/1419988)
- HipChat (https://www.hipchat.com/)

Checked/tested on Ubuntu 14.04.4 LTS 64x
