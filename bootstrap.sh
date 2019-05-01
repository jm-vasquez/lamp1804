#!/usr/bin/env bash

sudo apt-get update -y
sudo apt-get install software-properties-common -y

sudo apt-get install -y apache2 libapache2-mod-fastcgi apache2-mpm-worker
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

#maria db 10.3
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] http://mirror.rackspace.com/mariadb/repo/10.3/ubuntu bionic main'
apt-get update -y

# Setting MySQL root user password root/root
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y mariadb-server mariadb-client

# Install the Rest
sudo apt-get install -y php7.2 libapache2-mod-php7.2 php7.2-curl php7.2-gd php7.2-xdebug php7.2-mysql php7.2-dom php7.2-cli php7.2-json php7.2-common php7.2-mbstring php7.2-opcache php7.2-readline php7.2-soap

# Loading needed modules to make apache work
sudo a2enmod actions fastcgi rewrite
sudo service apache2 reload
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod ssl
sudo service apache2 restart