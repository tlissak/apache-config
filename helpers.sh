#!/bin/bash

enableSSH(){
    nano /etc/ssh/sshd_config
    PermitRootLogin yes
    service sshd restart
}
removePHP(){
    remove php
    apt-get -y purge php8.*
}


#Dev Only
cpPhpConfigForce(){
	PHPVER=8.0
	input=conf/php.ini
	output=/etc/php/$PHPVER/apache2/conf.d/php.ini
	cp $input $output
	output=/etc/php/$PHPVER/cli/conf.d/php.ini
	cp $input $output
}



#Depracted :
editPhpConfig(){

	
	input="/etc/php/$PHPVER/apache2/php.ini"
	output="/etc/php/$PHPVER/apache2/php-MODIFIED.ini"


	if [ ! -f $output ]; then
		msg_info "File not found!"
	else
		msg_info "File ${output} already Exist"
		return
	fi


	sed $input -e "2s/^/\n;;;;;;;;;;;;;;;;;;;\n; MODIFIED BY SCRIPT ;\n;;;;;;;;;;;;;;;;;;;\n/" \
	| sed  -e "s/display_errors = Off/display_errors = On/"  \
	| sed -e "s/display_startup_errors = Off/display_startup_errors = On/"  \
	| sed -e "s/short_open_tag = Off/short_open_tag = On/"  \
	| sed -e "s/;max_input_vars = 1000/max_input_vars = 20000/"  \
	| sed -e "s/expose_php = On/expose_php = Off/"  \
	| sed -e "s/post_max_size = 8M/post_max_size = 500M/"  \
	| sed -e "s/upload_max_filesize = 2M/upload_max_filesize = 1000M/"  \
	| sed -e "s/;date.timezone =/date.timezone = Europe\/Paris/"  \
	> $output


}