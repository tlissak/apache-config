## update system

    sudo apt-get update 
    sudo apt-get upgrade

## ssl 
    sudo apt-get install openssl

## get / save certificate

  mkdir /etc/ca/
    
sudo chown root:root /etc/ssl/private/vsftpd.cert.*
sudo chmod 600 /etc/ssl/private/vsftpd.cert.*
  
## install apache

    sudo apt-get install apache2
    a2enmod ssl imap fileinfo gd mbstring openssl pdo_mysql pdo_sqlite soap
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
  
##  install vsftpd
  
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
# require_ssl_reuse=NO # Certains clients FTP nécessitent cette ligne

ssl_tlsv1=YES
ssl_sslv2=YES
ssl_sslv3=YES

rsa_cert_file=/etc/ssl/private/vsftpd.cert.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.key.pem
   
 ## then reload   
    sudo service vsftpd reload
   
