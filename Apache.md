Download Apache From : [Apache Haus](https://www.apachehaus.com/cgi-bin/download.plx)

Download PHP from :  [PHP windows](https://windows.php.net/download) **  PHP is THREAD SAFE

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
