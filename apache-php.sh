#!/bin/bash

mkdir -p /etc/apt/sources.list.d
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
apt-key adv --fetch-keys 'https://packages.sury.org/php/apt.gpg' > /dev/null 2>&1
apt-get -y update


apt-get install -y openssl
apt-get install -y curl
apt-get install -y git-all
apt-get install -y zip 
apt-get install -y apache2
apt-get install -y php8.1
apt-get install -y libapache2-mod-php8.1
apt-get install -y php8.1-sqlite3
apt-get install -y php8.1-mysql

apt-get install -y php-curl

a2enmod ssl rewrite

apt-get install -y php-soap php-imap php-fpm php-intl php-json php-mysql php-zip php-gd php-mbstring php-xml 
phpenmod imap fileinfo gd mbstring openssl pdo_mysql pdo_sqlite soap curl 

/etc/init.d/apache2 reload

cp /etc/php/8.1/apache2/php.ini  php.ini.orig
sed 's/;\(extension=\(pdo_mysql\|pdo_sqlite\|mbstring\)\)/\1/g;' php.ini.orig > php.ini

mkdir -p ../www
cp index.php ../www/index.php

cp website.conf /etc/apache2/sites-available/website.conf
cp website-ssl.conf /etc/apache2/sites-available/website-ssl.conf

a2dissite 000-default
a2ensite website 
a2ensite website-ssl 

/etc/init.d/apache2 reload

/etc/init.d/apache2 restart

#for any changes at /etc/apache2/sites-available/website just do 
#/etc/init.d/apache2 reload or restart