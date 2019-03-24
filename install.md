# Installationsanleitung für Vagrant
aldkjf
### Step 1: Ubuntu updaten / vorbereiten
 Updates the Ubuntu Repositorys
```bash
sudo apt-get update
sudo apt-get upgrade
```
...Oder

Nach der Installtation des UbuntuServers soll noch der Server upgedatet werden.
```Bash
# sudo apt update && sudo apt dist-upgrade && sudo apt autoremove
```

#### Installtation PHP
PHP Version auslesen
```Bash
php -v
```
```Bash
php -v
```
### Step 2: Installation Apache HTTP Server
Um den Ubuntu Server zu installieren, müssen die folgenden Komandos ausgeführt werden.
```Bash
sudo apt update
sudo apt install apache2
```

After installing Apache2, the commands below can be used to stop, start and enable Apache2 service to always start up with the server boots.

```Bash
# sudo systemctl stop apache2.service
# sudo systemctl start apache2.service
# sudo systemctl enable apache2.service
```

To test Apache2 setup, open your browser and browse to the server hostname or IP address and you should see Apache2 default test page as shown below.. When you see that, then Apache2 is working as expected..

### Step 3.1: Install MariaDB Database Server
MariaDB stands for M in LAMP and it’s a great place to start when looking at open source database server… Although MySQL was originally the default database server among Linux systems, MariaDB has taken over.. To install it run the commands below.
```
sudo apt-get install mariadb-server mariadb-client
```
After installing MariaDB database server, the commands below can be used to stop, start and enable MariaDB service to always start up when the server boots..

#### On Ubuntu 16.04 LTS

sudo systemctl stop mysql.service
sudo systemctl start mysql.service
sudo systemctl enable mysql.service
#### On Ubuntu 18.04 LTS and 18.10 

```
sudo systemctl stop mariadb.service
sudo systemctl start mariadb.service
sudo systemctl enable mariadb.service
```

After that, run the commands below to secure MariaDB server by creating a root password and disallowing remote root access.

```
sudo mysql_secure_installation
```

When prompted, answer the questions below by following the guide.

```
Enter current password for root (enter for none): Just press the Enter
Set root password? [Y/n]: Y
New password: Enter password
Re-enter new password: Repeat password
Remove anonymous users? [Y/n]: Y
Disallow root login remotely? [Y/n]: Y
Remove test database and access to it? [Y/n]:  Y
Reload privilege tables now? [Y/n]:  Y
```

Restart MariaDB server

To test if MariaDB is installed, type the commands below to logon to MariaDB server

```
sudo mysql -u root -p
```

Then type the password you created above to sign on… if successful, you should see MariaDB welcome message

### Step 3.2: Installation MySQL DB Server
At the time of writing this article, the latest version of MySQL available from the official Ubuntu repositories is MySQL version 5.7.

To install MySQL on your Ubuntu server follow the steps below:

First update the apt package index by typing:
```Bash
sudo apt update
```

Then install the MySQL package with the following command:
``` Bash
sudo apt install mysql-server
```

Once the installation is completed, the MySQL service will start automatically. To check whether the MySQL server is running, type:

```Bash
sudo systemctl status mysql
```
 [output]
```Shell
* mysql.service - MySQL Community Server
   Loaded: loaded (/lib/systemd/system/mysql.service; enabled; vendor preset: enabled)
   Active: active (running) since Thu 2018-12-20 02:30:41 PST; 2min 29s ago
 Main PID: 29563 (mysqld)
    Tasks: 27 (limit: 2317)
   Memory: 171.6M
   CGroup: /system.slice/mysql.service
           `-29563 /usr/sbin/mysqld --daemonize --pid-file=/run/mysqld/mysqld.pid

Dec 20 02:30:41 ubuntu1810.localdomain systemd[1]: Starting MySQL Community Server...
Dec 20 02:30:41 ubuntu1810.localdomain systemd[1]: Started MySQL Community Server.
```
#### Securing MySQL
MySQL server package comes with a script called mysql_secure_installation that can perform several security related operations.

Run the script by typing:
```
sudo mysql_secure_installation
```
You will be asked to configure the VALIDATE PASSWORD PLUGIN which is used to test the strength of the MySQL users passwords and improve the security. There are three levels of password validation policy, low, medium and strong. Press ENTER if you don’t want to set up the validate password plugin.

On the next prompt you will be asked to set a password for the MySQL root user. Once you do that the script will also ask you to remove the anonymous user, restrict root user access to the local machine and remove the test database. You should answer “Y” (yes) to all questions.

## Step 4: Installation PhpMyAdmin
### Step 1 — Installing phpMyAdmin
To get started, we will install phpMyAdmin from the default Ubuntu repositories.

This is done by updating your server’s package index and then using the apt packaging system to pull down the files and install them on your system:

```
sudo apt update
sudo apt install phpmyadmin php-mbstring php-gettext
```

This will ask you a few questions in order to configure your installation correctly.

Warning: When the prompt appears, “apache2” is highlighted, but not selected. If you do not hit SPACE to select Apache, the installer will not move the necessary files during installation. Hit SPACE, TAB, and then ENTER to select Apache.

For the server selection, choose apache2
Select Yes when asked whether to use dbconfig-common to set up the database
You will then be asked to choose and confirm a MySQL application password for phpMyAdmin
The installation process adds the phpMyAdmin Apache configuration file into the /etc/apache2/conf-enabled/ directory, where it is read automatically. The only thing you need to do is explicitly enable the mbstring PHP extension, which you can do by typing:

```
sudo phpenmod mbstring
```

Afterwards, restart Apache for your changes to be recognized:

sudo systemctl restart apache2
phpMyAdmin is now installed and configured. However, before you can log in and begin interacting with your MySQL databases, you will need to ensure that your MySQL users have the privileges required for interacting with the program.


### Step 4: Install PHP And Related Modules
The last component of the LAMP stack is PHP… It’s the P in the LAMP stack… To install PHP and related PHP modules, run the commands below…
```Bash
sudo apt install php libapache2-mod-php php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-mysql php-cli php-zip php-curl
```

After installing PHP, run the commands below to find the version installed on the server…
```Bash
php -v
```

You should see an output like the one below:
```Bash
PHP 7.2.10-0ubuntu0.18.04.1 (cli) (built: Sep 13 2018 13:45:02) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
    with Zend OPcache v7.2.10-0ubuntu0.18.04.1, Copyright (c) 1999-2018, by Zend Technologies
```
The version number determines the location of PHP default configuration file… For PHP 7.2, the location is as shown below:
```Bash
sudo nano /etc/php/7.2/apache2/php.ini
```
Replace the version number above with the version of PHP installed..,..

When the file opens, make the changes on the following lines below in the file and save. The value below are great settings to apply in your environments.

```Ini
file_uploads = On
allow_url_fopen = On
memory_limit = 256M
upload_max_filesize = 100M
max_execution_time = 360
date.timezone = America/Chicago
```
After making the change above, save the file and close out.

### Step 4: Restart Apache2
When you’re done making PHP changes above, run the commands below to restart Apache2 HTTP server for PHP settings to apply…
```Bash
sudo systemctl restart apache2.service
```

To test PHP settings with Apache2, create a phpinfo.php file in Apache2 root directory by running the commands below
```Bash
sudo nano /var/www/html/phpinfo.php
```

Then type the content below and save the file.
```PHP
<?php phpinfo( ); ?>
```

Save the file.. then browse to your server hostname followed by phpinfo.php

-- http://localhost/phpinfo.php

You should see PHP default test page…