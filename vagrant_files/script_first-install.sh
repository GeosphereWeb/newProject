#!/usr/bin/env bash

# Updates the Ubuntu Repositorys
sudo apt-get update
sudo apt-get upgrade


###########################################################
####################### FTP Server ########################
#sudo apt-get install proftpd-basic
sudo apt-get install -y vsftpd
#### configfile #  /etc/vsftpd.conf ####
## anonymous_enable=Yes
## write_enable=YES
### sudo service vsftpd restart ##

###########################################################
####################### PHP 7.2 ###########################

############## Add the PHP repository
# First, make sure you have the following package installed so you can add repositories:
sudo apt-get install -y libapache2-mod-php php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-mysql php-cli php-zip php-curl

# And finally, update your package list:
sudo apt-get update


###########################################################
####################### MySQL 5.7 ###########################
echo 'mysql-server mysql-server/root_password password root' | debconf-set-selections
echo 'mysql-server mysql-server/root_password_again password root' | debconf-set-selections
apt-get update
apt-get install -y mysql-server
#apt-get install -q -y mysql-server
#mysqladmin -u root password root


###########################################################
################ Apache2 Config ###########################
###########################################################

# Installs Apache2
sudo apt-get install -y apache2
sudo a2enmod rewrite

# PhpMyAdmin Installation
#
# Configure the Settings with debconf-set-selections
# Install phpmyadmin with noninteractive mode (it will use the set settings)
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections
apt-get install -q -y phpmyadmin


###########################################################
################ Install zusaetzl. Software ###############
###########################################################

# Zum installieren für 'mkpasswd'
sudo apt-get install -y whois

# Installation MidnightComander
sudo apt-get install -y mc

#  ZIP
sudo apt-get install -y zip

# Installs Git
sudo apt-get install -y git

# Installs the Graphicsmagick Lib's for use in TYPO3
sudo apt-get install -y graphicsmagick


sudo mkdir /var/www/devProject
sudo chown -R www-data:www-data /var/www/*

################ vorbereitung fuer NEOS #########################
# Install composer
cd ~
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

######################## Install ZSH ############################
sudo apt-get install -y zsh
#sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mkdir -p ~/.oh-my-zsh/custom/plugins
cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/sandstorm/oh-my-zsh-flow-plugin.git flow

#sudo chown -R vagrant:vagrant ~/.oh-my-zsh
#sudo chown -R vagrant:vagrant ~/flow

chsh -s $(which zsh)


######################## VHOST ##################################
# Enable Vhost.conf
sudo a2ensite projectVhost.conf

#sudo usermod -a -G www-data vagrant
sudo chmod o+w /var/www/devProject
sudo chmod g+w /var/www/devProject
