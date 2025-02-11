
install debian
```
bash -c "$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/ct/debian.sh)"
```
```
apt install -y git
```

install apache2

```
apt install -y apache2
```

```
nano /etc/apache2/sites-enabled/000-default.conf
```

visit port 80


enable root login to ssh 

```
nano /etc/ssh/sshd_config

```

```
service sshd restart

```

change root pwd :
```
passwd
```
B1!*


```
apt-get -qqy install apt-transport-https lsb-release ca-certificates wget
	wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg 
	sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
	apt-get -qqy update


apt-get -qy install php8.4 php-common libapache2-mod-php

	apt-get -qqy install php8.4 php8.4-common
	apt-get -qqy install php8.4-fileinfo php8.4-pdo-sqlite php8.4-ftp php8.4-soap php8.4-imap php-fpm php8.4-intl  php8.4-mysql php8.4-pdo-mysql php8.4-zip php8.4-gd php8.4-mbstring php8.4-curl php8.4-xml


a2dismod php8.3
a2enmod php8.4
systemctl restart apache2


```
