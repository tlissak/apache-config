## update system

    sudo apt-get update 
    sudo apt-get upgrade

## ssl & curl
    sudo apt-get install openssl
    sudo apt-get install curl

#list of listinig ports 

sudo lsof -i -P -n

## get / save certificate

  mkdir /etc/ca/
    
sudo chown root:root /etc/ssl/private/vsftpd.cert.*
sudo chmod 600 /etc/ssl/private/vsftpd.cert.*
  
## install apache

    sudo apt-get install apache2
    a2enmod ssl imap fileinfo gd mbstring openssl pdo_mysql pdo_sqlite soap
    sudo apt-get install php-curl
    or
    sudo apt-get install php8.0-curl
    a2enmod curl

## add vhosts : 

  a2ensite default-ssl

## new site : 

    sudo /etc/init.d/apache2 restart
    
    
##  install php8
  
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:ondrej/php
    sudo apt install php8.0 libapache2-mod-php8.0
  
##  restart apache
  
    sudo systemctl restart apache2
  
##  install vsftpd https://doc.ubuntu-fr.org/vsftpd
  
    sudo apt install vsftpd
  
  
# copy settings
mv /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default
  
##  add user
  
    
    sudo groupadd sftp_users
    useradd MY_USER
    passwd MY_USER
    usermod -g sftp_users MY_USER
    usermod -d /var/www MY_USER
    
##  restart vsftpd
  
    sudo systemctl start vsftpd
    sudo systemctl enable vsftpd
  
##  open ports firewall 
  
    sudo ufw allow 2121/tcp
    sudo ufw status
    
##  enable ssl
  
  
     sudo openssl req -new -x509 -days 365 -nodes -out /etc/ssl/private/vsftpd.cert.pem -keyout /etc/ssl/private/vsftpd.key.pem
     
    sudo nano /etc/vsftpd.conf
    
listen=YES
listen_port=2121   

local_enable=YES


rsa_cert_file=/etc/ssl/private/vsftpd.cert.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.key.pem
ssl_enable=YES
allow_anon_ssl=NO
force_local_data_ssl=NO
force_local_logins_ssl=YES
ssl_tlsv1=YES

pasv_enable=YES
pasv_min_port=13450
pasv_max_port=13500
pasv_addr_resolve=YES



   
 ## then reload   
    sudo service vsftpd reload
    
    sudo  chmod 777 /var/www
   
   
   iptables -t filter -A INPUT -p tcp --dport 13450:13500 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 13450:13500 -j ACCEPT
    
## mariadb https://doc.ubuntu-fr.org/mariadb or https://doc.ubuntu-fr.org/mysql


sudo apt install mariadb-server

sudo systemctl start mariadb
 /etc/mysql/mysql.conf.d/mysqld.cnf :

## firewall open port 

sudo ufw allow 21/tcp
sudo ufw allow 587/tcp
sudo ufw allow 80/tcp
sudo ufw allow 22/tcp
sudo ufw allow 443/tcp


## postfix as relay https://www.linode.com/docs/guides/postfix-smtp-debian7/

sudo apt-get install libdb5.1 postfix procmail sasl2-bin

    /etc/postfix/sasl_passwd

    [smtp.mandrillapp.com]:587 USERNAME:API_KEY
    [smtp.gmail.com]:587 username@gmail.com:password
   
    sudo postmap /etc/postfix/sasl_passwd
   
    sudo chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
    sudo chmod 0600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
 
    /etc/postfix/main.cf
 
    relayhost = [smtp.gmail.com]:587
    smtp_sasl_auth_enable = yes
    smtp_sasl_security_options = noanonymous
    smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
    smtp_use_tls = yes
    smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt

     sudo service postfix restart
 
## Email testing

        sudo apt-get install mailutils  
        mail -s "Test subject" tlissak@gmail.com
        echo  "body of your email" | mail -s "This is a subject" -a "From: glasman@gmail.com" tlisak@gmail.com
        sudo service postfix restart
        
        
        
aws ports :

Personnalisé	TCP	20
SSH	TCP	22
HTTP	TCP	80
HTTPS	TCP	443
Personnalisé	TCP	2121
Personnalisé	TCP	13450-13500


