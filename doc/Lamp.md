## update system
```
sudo apt-get update 
sudo apt-get upgrade
```
## ssl & curl
```
sudo apt-get install openssl
sudo apt-get install curl
```
#list of listinig ports 
```
sudo lsof -i -P -n
```
## get / save certificate
```
mkdir /etc/ca/
``` 
```
sudo chown root:root /etc/ssl/private/vsftpd.cert.*
sudo chmod 600 /etc/ssl/private/vsftpd.cert.*
```


## [Install postfix](postfix.md)
## [Install vsftpd](vsftpd.md)

## install apache
```
sudo apt-get install apache2
a2enmod ssl imap fileinfo gd mbstring openssl pdo_mysql pdo_sqlite soap
sudo apt-get install php-curl
or
sudo apt-get install php8.0-curl
a2enmod curl
```
## add vhosts : 
```
a2ensite default-ssl
```
## new site : 
```
sudo /etc/init.d/apache2 restart
```  
    
##  install php8
```
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt install php8.0 libapache2-mod-php8.0
```
##  restart apache
```
sudo systemctl restart apache2
```

## firewall open port 
```
sudo ufw allow 21/tcp
sudo ufw allow 587/tcp
sudo ufw allow 80/tcp
sudo ufw allow 22/tcp
sudo ufw allow 443/tcp
```

aws open ports :
```
Personnalisé	TCP	20
SSH	TCP	22
HTTP	TCP	80
HTTPS	TCP	443
Personnalisé	TCP	2121
Personnalisé	TCP	13450-13500
```




