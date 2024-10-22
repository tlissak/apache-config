#!/bin/sh

apt-get -y install software-properties-common
add-apt-repository ppa:ondrej/php
apt update

apt-get -y install php8.0 
apt-get -y install php8.0-common
#libapache2-mod-php8.0

#apt-get -qy install php-fileinfo php-pdo-sqlite php-ftp php-soap php-imap php-fpm php-intl php-json php-mysql php-pdo-mysql php-zip php-gd php-mbstring php-curl php-xml 
	

#read -e -p "PHP Version:" -i "8.0" PHPVER

#echo $PHPVER

#apt-get -qy install php8.0 php-common libapache2-mod-php

#echo "Doen"
