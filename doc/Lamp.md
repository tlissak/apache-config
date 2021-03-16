## update system

    sudo apt-get update 
    sudo apt-get upgrade

## ssl & curl
    sudo apt-get install openssl
    sudo apt-get install curl

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
  
##  add user
  
    sudo useradd --system ftp

##  restart vsftpd
  
    sudo systemctl start vsftpd
    sudo systemctl enable vsftpd
  
##  open ports firewall 
  
    sudo ufw allow 2121/tcp
    sudo ufw status
    
##  enable ssl
  
  
     sudo openssl req -new -x509 -days 365 -nodes -out /etc/ssl/private/vsftpd.cert.pem -keyout /etc/ssl/private/vsftpd.key.pem
     
    sudo vim /etc/vsftpd.conf
    
listen_port=2121   
ssl_enable=YES
allow_anon_ssl=NO
force_local_data_ssl=NO
force_local_logins_ssl=YES

ssl_tlsv1=YES
ssl_sslv2=YES
ssl_sslv3=YES

rsa_cert_file=/etc/ssl/private/vsftpd.cert.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.key.pem
   
 ## then reload   
    sudo service vsftpd reload
    
    
## mariadb https://doc.ubuntu-fr.org/mariadb or https://doc.ubuntu-fr.org/mysql


sudo apt install mariadb-server

sudo systemctl start mariadb
 /etc/mysql/mysql.conf.d/mysqld.cnf :

firewall open port 


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
        mail -s "Test subject" recipient@domain.com
        echo  “body of your email” | mail -s “This is a subject” - a “From: you@example.com” recipient@elsewhere.com
        sudo service postfix restart
