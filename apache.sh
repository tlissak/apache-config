#!/bin/bash


installDependencies() {
	## Install dependencies 
	msg_info "Installing dependencies openssl curl git zip"
	apt-get -qqy install openssl curl git-all zip
	msg_ok "Install dependencies done"
}

installApache() {
    apache2 -v > /dev/null 2>&1
    APACHE_VER=$?
    if [[ $APACHE_VER -ne 0 ]]; then
        msg_info 'Installing apache..'
    else

        msg_info "apache2 is already installed " 
        apache2 -v
        return
    fi
     
	# Apache
	apt-get -qqy install apache2 apache2-doc libexpat1 ssl-cert	
	# apache2-mpm-prefork apache2-utils 
	msg_ok "Apache installed"
}

checkApacheConfig() {
	# check Apache configuration: 
	msg_info "Check Apache configuration"	
	apachectl configtest
	msg_ok "Checked apache cfg"

}

setWWWPermissions() {
	# Permissions
	msg_info "Setting Ownership for /var/www.. "
	chown -R www-data:www-data /var/www
	chmod -R g+rw /var/www
}

restartApache() {
	# Restart Apache
	msg_info "Restarting Apache.. "
	service apache2 restart
    #systemctl restart apache2
}


enableApacheMods() {
	# Enable mod_rewrite,  .htaccess files
	msg_info "Enabling Modules.."
	a2enmod rewrite ssl	
	#a2enmod curl rewrite ssl imap fileinfo gd mbstring openssl pdo_mysql pdo_sqlite soap 
	#phpenmod mbstring mcrypt
}
