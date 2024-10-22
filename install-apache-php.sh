#!/bin/sh

#######################################
# install  :
# bash -c "$(wget -qLO - https://github.com/tlissak/settings/raw/main/install-apache-php.sh)"
# Bash script to install an Apache PHP stack For Debian based systems.
# Base on https://github.com/aamnah/bash-scripts/blob/master/install/amp_debian.sh
# Written by @AamnahAkram from http://aamnah.com

# In case of any errors just re-run the script. Nothing will be re-installed except for the packages with errors.
#######################################



# COLORS
color() {
  Color_Off='\033[0m'       # Text Reset
  Yellow=$(echo "\033[33m")
  Blue=$(echo "\033[36m")
  Red=$(echo "\033[01;31m")
  Purple=$(echo "\033[0;35m")
  Cyan=$(echo "\033[0;36m")  
  Green=$(echo "\033[1;92m")
  #DGN=$(echo "\033[32m")
  #BGN=$(echo "\033[4;92m")
  CL=$(echo "\033[m")
  CM="${Green}✓${CL}"
  CROSS="${Red}✗${CL}"
  BFR="\\r\\033[K"
  HOLD=" "
}
# This function displays an informational message with a yellow color. msg_info "Your message"
msg_info() {
  local msg="$1"
  echo -ne " ${HOLD} ${Yellow}${msg}"
}

# This function displays a success message with a green color. usage : msg_ok "Your message"
msg_ok() {
  printf "\e[?25h"
  local msg="$1"
  echo -e "${BFR} ${CM} ${Green}${msg}${CL}"
}

# This function displays a error message with a red color. msg_error "Your message"
msg_error() {
  printf "\e[?25h"
  local msg="$1"
  echo -e "${BFR} ${CROSS} ${Red}${msg}${CL}"
}

catch_errors() {
  set -Eeuo pipefail
  trap 'error_handler $LINENO "$BASH_COMMAND"' ERR
}

# This function is called when an error occurs. It receives the exit code, line number, and command that caused the error, and displays an error message.
error_handler() {
  printf "\e[?25h"
  local exit_code="$?"
  local line_number="$1"
  local command="$2"
  local error_message="${Red}[ERROR]${CL} in line ${Red}$line_number${CL}: exit code ${Red}$exit_code${CL}: while executing command ${Yellow}$command${CL}"
  echo -e "\n$error_message\n"
}


updateOS() {
	# Update system repos
	msg_info "Updating package repositories.."
	apt-get -qq update 
	msg_ok "Update sys done"
}
installDependencies() {
	## Install dependencies 
	msg_info "Installing dependencies openssl curl git zip"
	apt-get -qy install openssl curl git-all zip
	msg_ok "Install dependencies done"
}
installApache() {
	# Apache
	msg_info "Installing Apache.."	
	apt-get -qy install apache2 apache2-doc libexpat1 ssl-cert	
	# apache2-mpm-prefork apache2-utils 
	msg_ok "Apache installed"
}

checkApacheConfig() {
	# check Apache configuration: 
	msg_info "Check Apache configuration"	
	apachectl configtest
	msg_ok "Checked apache cfg"

}
installPHP() {


	echo $PHPVER


	# PHP and common Modules
	msg_info "Installing PHP"

	read -e -p "PHP Version:" -i "8.0" PHPVER

	#echo $PHPVER

	apt-get -qy install php$PHPVER php-common libapache2-mod-php
	msg_ok "PHP installed"

	msg_info "Installing common Modules.. "
	apt-get -qy install php-curl php-dom php-ftp php-pdo php-pdo-mysql php-fileinfo php-simplexml php-imap php-dev php-gd php-imagick php-intl php-ps php-json php-mbstring php-mysql php-pear php-pspell php-xml php-zip php-xsl php-mcrypt php-soap
	#dpkg --configure -a
	#dpkg --remove --force-remove-reinstreq gsfonts
	msg_ok "common Modules installed"
}

enableMods() {
	# Enable mod_rewrite,  .htaccess files
	msg_info "Enabling Modules.."
	a2enmod rewrite ssl	
	#a2enmod curl rewrite ssl imap fileinfo gd mbstring openssl pdo_mysql pdo_sqlite soap 
	phpenmod mbstring mcrypt
}

setPermissions() {
	# Permissions
	msg_info "Setting Ownership for /var/www.. "
	chown -R www-data:www-data /var/www
}

restartApache() {
	# Restart Apache
	msg_info "Restarting Apache.. "
	service apache2 restart
}

apacheloadCostumPhpIni(){

	
	upload_max_filesize=240M
	post_max_size=50M
	max_execution_time=100
	max_input_time=223

	for key in upload_max_filesize post_max_size max_execution_time max_input_time
	do
	sed -i "s/^\($key\).*/\1 $(eval echo = \${$key})/" php.ini
	done

export PHP_INI_PATH=etc/php/8.1/fpm/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 60/' $PHP_INI_PATH
sed -i 's/memory_limit = 128M/memory_limit = 256M/' $PHP_INI_PATH


	mkdir /etc/php/web1/

	cp /etc/php/8.1/apache2/php.ini /etc/php/web1/
}

installPhpFromRepo() {
	apt-get -qy install software-properties-common
	add-apt-repository ppa:ondrej/php
	apt-get -qy install php8.0 libapache2-mod-php8.0

	apt-get -qy install php-fileinfo php-pdo-sqlite php-ftp php-soap php-imap php-fpm php-intl php-json php-mysql php-pdo-mysql php-zip php-gd php-mbstring php-curl php-xml 
	#edit file : nano /etc/php/8.0/apache2/php-override.ini

	
	
	

#Already
	#display_errors = On
	#display_startup_errors = On
	#short_open_tag = On
	#max_input_vars = 20000
	#expose_php = Off
	#post_max_size = 500M
	#upload_max_filesize = 2000M
	#date.timezone=Europe/Paris	

	systemctl restart apache2

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
	msg_info  "Install composer .. "
	wget -O composer-setup.php https://getcomposer.org/installer
	php composer-setup.php --install-dir=/usr/local/bin --filename=composer
	chown -R $USER ~/.composer/
	composer update --ignore-platform-reqs
	
	#if composer update failed with
	#file_put_contents(./composer.lock): Failed to open stream: Permission denied
	#do :
	#chmod 0777 ./composer.lock
}

#TODO
installVsftpd() {
	apt-get install vsftpd
	
	mv /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default
	
	#enable service and start
	systemctl start vsftpd
	systemctl enable vsftpd

	#change config 
	#TODO
	# user and permissions
	#TODO
}

cleanup() {
	msg_info "Cleaning up"
	apt-get -y autoremove
	apt-get -y autoclean
	msg_ok "Cleaned"
}

# RUN 
color
catch_errors

updateOS
installDependencies
installApache
checkApacheConfig
installPHP
enableMods
setPermissions
restartApache
installComposer
cleanup