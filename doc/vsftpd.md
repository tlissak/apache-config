##  install vsftpd https://doc.ubuntu-fr.org/vsftpd
```
sudo apt install vsftpd
```
  
# copy settings
```
mv /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default
```
##  add user
```
sudo groupadd sftp_users
useradd MY_USER
passwd MY_USER
usermod -g sftp_users MY_USER
usermod -d /var/www MY_USER
```
##  restart vsftpd
```
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
```
##  open ports firewall 
```
sudo ufw allow 2121/tcp
sudo ufw status
``` 
##  enable ssl
  
```
sudo openssl req -new -x509 -days 365 -nodes -out /etc/ssl/private/vsftpd.cert.pem -keyout /etc/ssl/private/vsftpd.key.pem
```
```
sudo nano /etc/vsftpd.conf
```

important comment this :
```
#listen_ipv6
```
```
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
```
  
## then reload
 ```
sudo service vsftpd reload
```
Give write permissions to folder 
```
sudo chown 666 testuser:sftp_users /var/www 
```

```
iptables -t filter -A INPUT -p tcp --dport 13450:13500 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 13450:13500 -j ACCEPT
```
