#!/bin/sh

#######################################
# Bash script to install an Apache PHP stack For Debian based systems.

Base on https://github.com/aamnah/bash-scripts/blob/master/install/amp_debian.sh
# Written by @AamnahAkram from http://aamnah.com

# In case of any errors just re-run the script. Nothing will be re-installed except for the packages with errors.
#######################################

#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan


update() {
	# Update system repos
	echo -e "\n ${Cyan} Updating package repositories.. ${Color_Off}"
	sudo apt -qq update 
}
installDependencies() {
	# Dependencies
	## Install dependencies 
	echo -e "$Cyan \n Installing dependencies openssl curl git zip $Color_Off"
	apt-get install openssl curl git-all zip
}
installApache() {
	# Apache
	echo -e "\n ${Cyan} Installing Apache.. ${Color_Off}"
	sudo apt -qy install apache2 apache2-doc libexpat1 ssl-cert
	# check Apache configuration: apachectl configtest
	# apache2-mpm-prefork apache2-utils 
}

installPHP() {
	# PHP and Modules
	echo -e "\n ${Cyan} Installing PHP and common Modules.. ${Color_Off}"

	# PHP
	sudo apt -qy install php php-common libapache2-mod-php php-curl php-dev php-gd php-gettext php-imagick php-intl php-ps php-mbstring php-mysql php-pear php-pspell php-recode php-xml php-zip php-xsl php-mcrypt php-soap
}

enableMods() {
	# Enable mod_rewrite,  .htaccess files
	echo -e "\n ${Cyan} Enabling Modules.. ${Color_Off}"

	sudo a2enmod curl rewrite ssl imap fileinfo gd mbstring openssl pdo_mysql pdo_sqlite soap 	
	sudo phpenmod mbstring mcrypt
}

setPermissions() {
	# Permissions
	echo -e "\n ${Cyan} Setting Ownership for /var/www.. ${Color_Off}"
	sudo chown -R www-data:www-data /var/www
}

restartApache() {
	# Restart Apache
	echo -e "\n ${Cyan} Restarting Apache.. ${Color_Off}"
	sudo service apache2 restart
}

installPhpFromRepo() {
	apt install software-properties-common
	add-apt-repository ppa:ondrej/php
	apt install php8.0 libapache2-mod-php8.0

	apt install php-openssl php-fileinfo php-pdo_sqlite php-ftp php-soap php-imap php-fpm php-intl php-json php-mysql php-zip php-gd php-mbstring php-curl php-xml 

	edit file : nano /etc/php/8.0/apache2/php-override.ini

	max_input_vars = 20000
	max_input_time=-1
	max_execution_time=9000
	display_errors = On
	display_startup_errors = On
	short_open_tag = On
	expose_php = Off
	post_max_size = 500M
	upload_max_filesize = 2000M
	date.timezone=Europe/Paris
	
	
	systemctl restart apache2

}

installProftp() {
	apt-get install proftpd
}

installComposerWithPhp() {
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	php composer-setup.php
	php -r "unlink('composer-setup.php');"
}
installComposer() {
	EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

	if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
	then
		>&2 echo 'ERROR: Invalid installer checksum'
		rm composer-setup.php
		exit 1
	fi

	php composer-setup.php --quiet
	RESULT=$?
	rm composer-setup.php
	exit $RESULT
}

installComposerM1() {
	# Install Composer
	echo -e "\n ${Cyan} Install composer .. ${Color_Off}"
	wget -O composer-setup.php https://getcomposer.org/installer
	php composer-setup.php --install-dir=/usr/local/bin --filename=composer
	chown -R $USER ~/.composer/
	composer update --ignore-platform-reqs
	
	#if composer update failed with
	#file_put_contents(./composer.lock): Failed to open stream: Permission denied
	#do :
	#chmod 0777 ./composer.lock
}

# RUN
update
installDependencies
installApache
installPHP
enableMods
setPermissions
restartApache

