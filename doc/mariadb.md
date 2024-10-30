# MariaDB LXC

````
bash -c "$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/ct/mariadb.sh)"
````

````
/etc/init.d/mysql start
mysql -u root
SELECT host FROM mysql.user WHERE User = 'root';
CREATE USER 'root'@'192.168.0.18' IDENTIFIED BY '$PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.0.18';
SELECT host FROM mysql.user WHERE User = 'root';
````

make sure the bind-address is commanted line at
````
nano /etc/mysql/mariadb.conf.d/50-server*
````

````
nano /etc/mysql/my.cnf
````
add at the end of this file 
````
[mariadb]
port = 3361

key_buffer_size = 16M
max_allowed_packet = 128M
sort_buffer_size = 512K
net_buffer_length = 8K
read_buffer_size = 256K
read_rnd_buffer_size = 512K
myisam_sort_buffer_size = 8M
lc-messages=fr_FR
# Avoid warning
explicit_defaults_for_timestamp=TRUE
server-id=1

````
restart service 
````
sudo /etc/init.d/mariadb restart
````
