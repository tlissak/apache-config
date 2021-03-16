  update system
sudo apt-get update 
sudo apt-get upgrade

  install apache
sudo apt-get install apache2
  
        sudo apt-get install openssl
    
  install php8
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt install php8.0 libapache2-mod-php8.0
  
  restart apache
sudo systemctl restart apache2
  
  install vsftpd
sudo apt install vsftpd
  
  add user
sudo useradd --system ftp

  restart vsftpd
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
  
  open ports firewall
  
sudo ufw allow 20/tcp
sudo ufw allow 21/tcp
sudo ufw status
  
  
  /etc/vsftpd.conf
   sudo service vsftpd reload
