# APMS Config

Quick Apache / Mysql Deployment File Config Guide 

Download Apache From : [Apache Haus](https://www.apachehaus.com/cgi-bin/download.plx)

Download PHP from :  [PHP windows](https://windows.php.net/download) ** important PHP is THREAD SAFE

Extract Apache and PHP

Apache and PHP should have the Same VC15 / VS16 versions

---

Apache :
---
/conf
rename httpd.conf to httpd-apms.conf
Copy httpd-vhosts.conf from extra into /conf folder

if you get unable to load curl 
add this line to httpd.conf file :
LoadFile "C:\apms\php-8.0.0-Win32-vs16-x64\libssh2.dll"

if you get unable to load pdo_sqlite 
add this line to httpd.conf file :
LoadFile "C:\apms\php-8.0.0-Win32-vs16-x64\libsqlite3.dll"


the fils should look like :

conf/httpd-apms.conf
---
```
#httpd.exe -k install -n "apms-apache-0" -f "conf/httpd-apms.conf"
Define SRVROOT "C:\apms\httpd-2.4.46-win64-VS16\Apache24"
Define VHOSTS "conf/httpd-vhosts.conf"
Define PHPBIN "C:\apms\php-8.0.0-Win32-vs16-x64\php8apache2_4"
Define PHPINI "C:/apms/php-8.0.0-Win32-vs16-x64"

ServerSignature Off
ServerTokens ProductOnly

ServerRoot "${SRVROOT}"

Listen 80
Listen 443

#for curl
LoadFile "C:\apms\php-8.0.0-Win32-vs16-x64\libssh2.dll"
#for pdo_sqlite
LoadFile "C:\apms\php-8.0.0-Win32-vs16-x64\libsqlite3.dll"

LoadModule php_module "${PHPBIN}"
<IfModule php_module>
	PHPIniDir "${PHPINI}"
	AddType application/x-httpd-php .php	
	DirectoryIndex index.php index.html index.htm
	
</IfModule>
```

httpd-vhosts.conf
---
```
<VirtualHost *:80>
   #ServerAdmin webmaster@dummy-host2.example.com
    DocumentRoot "c:/htdocs/"
    ServerName localhost
    ServerAlias 127.0.0.1
	ServerAlias your.local.hostname
	#ErrorLog "logs/dummy-host2.example.com-error.log"
    #CustomLog "logs/dummy-host2.example.com-access.log" common
	 <Directory "c:/htdocs/">
		AllowOverride all
		Require all granted
		Options +Indexes
    </Directory>   
</VirtualHost>
```

php.ini
---
```
display_errors = On
display_startup_errors = On
short_open_tag = On
expose_php = Off
extension_dir = "c:/apms/php-8.0.0-Win32-vs16-x64/ext"
upload_max_filesize = 2000M
extension=curl
extension=fileinfo
extension=gd
extension=mbstring
extension=openssl
extension=pdo_mysql
extension=pdo_sqlite
extension=soap
```



Httpd Service installation
---
open cmd with administrator rights
cd to Apache24/bin 
run the commande :
```
httpd -k install -n "apms-apache-1" -f conf/httpd-apms.conf
```
if you got troubles you can delete with 
or delete with
sc delete "Apms-Apache-1"

important !
create new firewall rule for programme and allow httpd in bin folder


Dont Forget to install Composer 
---


Mariadb / Mysql DB instruction
---
Download Mariadb zip and extract 

run 
```
\bin\mysql_install_db.exe (it will init the data folder)
```
installed service by using cmd.exe with administrator privileges
```
mysqld --install "apms-mysql"
```
// you can uninstall by  mysqld --uninstall "apms-mysql"
my.ini > should have section with 
```
[apms-mysql]
port		= 1336
socket		= /tmp/mysql.sock
start the service
```

change the root password :
go to \bin folder and type 
```
mysql -u root
FLUSH PRIVILEGES;
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('new_password');
```
restart service

add port exception to firewall 
---

Create user :
next login should have the -p parameter for password
```
mysql -u root -p 
```

```
CREATE USER 'USERNAME'@'%' IDENTIFIED BY 'password1';
read the user table :
SELECT User FROM mysql.user; 
Garante privilages :
GRANT ALL PRIVILEGES ON 'YOUR_DATABASE'.* TO 'USERNAME'@'%' IDENTIFIED BY 'password1';

FLUSH PRIVILEGES;
```
check the user privilages :
```
SHOW GRANTS FOR 'YOUR_DATABASE'@'%';
```

if you forgot your root password create an init-root-password.sql file and place it into the db folder 
```
ALTER USER 'root'@'localhost' IDENTIFIED BY 'YOUR_NEW_ROOT_PASSWORD';
```
stop services and run this command :
```
'bin>mysqld --init-file=C:\apms\mariadb-10.2.13-winx64\init-root-password.sql
```
