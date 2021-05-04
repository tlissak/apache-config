
## [Install vsftpd](vsftpd.md)

## [Install postfix](postfix.md)


## start as super user 
```
sudo su
```

## update system
```
apt-get update && upgrade
```
## install some dependencies
```
apt-get install openssl curl git-all zip
```
## install apache
```
apt-get install apache2
a2enmod ssl imap fileinfo gd mbstring openssl pdo_mysql pdo_sqlite soap
apt-get install php-curl
or
apt-get install php8.0-curl
a2enmod curl
```
## ssl / vhosts : 
ssl install point to current certificate
```
nano /etc/apache2/sites-available/default-ssl.conf
a2ensite default-ssl
a2enmod rewrite 

```  

## Firewall at aws open ports : 20 22 80 443 2121 13450-13500 then run

```  
iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT
```  

##  install php8
```
apt install software-properties-common
add-apt-repository ppa:ondrej/php
apt install php8.0 libapache2-mod-php8.0

apt install php-soap php-imap php-fpm php-intl php-json php-mysql php-zip php-gd php-mbstring php-curl php-xml 

edit file : nano /etc/php/8.0/apache2/php.ini

max_input_vars = 20000
max_input_time=-1
max_execution_time=9000
display_errors = On
display_startup_errors = On
short_open_tag = On
expose_php = Off
post_max_size = 500M
upload_max_filesize = 2000M
date.timezone=Europe/Paris
enable manual extensions : ftp fileinfo pdo_sqlite openssl 

systemctl restart apache2

```

## get composer 
no root or sudo
```
wget -O composer-setup.php https://getcomposer.org/installer
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
chown -R $USER ~/.composer/
composer update --ignore-platform-reqs
```

if composer update failed with  
```
file_put_contents(./composer.lock): Failed to open stream: Permission denied
```
do 
```
chmod 0777 ./composer.lock
```


## debug 

list of listinig ports 
```
lsof -i -P -n
```







