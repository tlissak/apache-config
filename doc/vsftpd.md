##  install vsftpd https://doc.ubuntu-fr.org/vsftpd
```
sudo apt install vsftpd
```
  
# new settings
```
mv /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default
```

##  Enable and start vsftpd
```
systemctl start vsftpd
systemctl enable vsftpd
```
##  open ports firewall 
```
iptables -t filter -A INPUT -p tcp --dport 2121 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 13450:13500 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 13450:13500 -j ACCEPT
``` 

##  config
  
```
sudo nano /etc/vsftpd.conf
```
```
listen=YES
vsftpd_log_file=/var/log/vsftpd.log
anonymous_enable=NO
local_enable=YES
write_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=YES
listen_port=2121
allow_anon_ssl=NO
force_local_data_ssl=NO
force_local_logins_ssl=YES
ssl_tlsv1=YES
pasv_enable=YES
pasv_min_port=13450
pasv_max_port=13500
pasv_addr_resolve=YES
allow_writeable_chroot=YES
```
  
## then reload
 ```
service vsftpd reload
```

## User and permissions
```
useradd foxdanni
passwd foxdanni
usermod -a -G www-data foxdanni
usermod -g www-data foxdanni
usermod -d /var/www/ foxdanni
usermod -s /usr/sbin/nologin
groups foxdanni
sudo chown foxdanni:www-data -R /var/www
sudo chown foxdanni:www-data -R /var/www/*
cd /var/wwww/
ls -ld /var/www/
```
