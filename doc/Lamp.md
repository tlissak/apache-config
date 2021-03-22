
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
sudo apt-get install apache2
a2enmod ssl imap fileinfo gd mbstring openssl pdo_mysql pdo_sqlite soap
sudo apt-get install php-curl
or
sudo apt-get install php8.0-curl
a2enmod curl
```
## ssl / vhosts : 
ssl install point to current certificate
```
sudo nano /etc/apache2/sites-available/default-ssl.conf
sudo a2ensite default-ssl
a2enmod rewrite 

```  

## Firewall at aws open ports : 20 22 80 443 2121 13450-13500 then run

```  
iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT
```  

##  install php8
```
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt install php8.0 libapache2-mod-php8.0

sudo apt install php-soap php-imap php-fpm php-json php-pdo php-mysql php-zip php-gd  php-mbstring php-curl php-xml 
sudo systemctl restart apache2

```

## get composer 
no root or sudo
```
wget -O composer-setup.php https://getcomposer.org/installer
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo chown -R $USER ~/.composer/
composer update --ignore-platform-reqs
```

if composer update failed with  
```
file_put_contents(./composer.lock): Failed to open stream: Permission denied
```
do 
```
sudo chmod 0777 ./composer.lock
```


## debug 

list of listinig ports 
```
sudo lsof -i -P -n
```







