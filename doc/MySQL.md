
Mariadb / Mysql DB instruction
---
Download Mariadb zip  [from here](https://mariadb.org/download/) and extract to apms folder 

run 
```
\bin\mysql_install_db.exe (it will init the data folder)
```
it will create default my.ini at the data folder 

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
```
start the service


change the root password :
go to \bin folder and type 
```
mysql -u root -P 1336
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
```
read the user table :
```
SELECT User FROM mysql.user; 
```
Garante privilages :
```
GRANT ALL PRIVILEGES ON 'YOUR_DATABASE'.* TO 'USERNAME'@'%' IDENTIFIED BY 'password1';
FLUSH PRIVILEGES;
```
check the user privilages :
```
SHOW GRANTS FOR 'USER_NAME'@'%';
```

Reset root password 
-----

if you forgot your root password create an init-root-password.sql file and place it into the db folder 
```
ALTER USER 'root'@'localhost' IDENTIFIED BY 'YOUR_NEW_ROOT_PASSWORD';
```
stop services and run this command :
```
'bin>mysqld --init-file=C:\apms\mariadb-10.2.13-winx64\init-root-password.sql
```
