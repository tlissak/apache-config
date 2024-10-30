#!/bin/bash

installVsftpd() {


    vsftpd -v > /dev/null 2>&1
    FTP_INSTALLED_VER=$?
    if [[ $FTP_INSTALLED_VER -ne 0 ]]; then
        msg_info 'FTP is not installed'
    else
        msg_ok "FTP is already installed "
        vsftpd -v
        return   
    fi

	apt-get -qy install vsftpd
	
    if [ ! -f /etc/vsftpd.conf.default ]; then
        mv /etc/vsftpd.conf /etc/vsftpd.conf.default
    fi

}



editFtpConfig(){



	input="/etc/vsftpd.conf.default"
	output="/etc/vsftpd.conf"

	if [ ! -f $output ]; then
		msg_info "Modify Ftp Config"
	else
		msg_info "File ${output} already Exist"
		#return
	fi


	sed $input -e "2s/^/\n#;;;;;;;;;;;;;;;;;;\n# MODIFIED BY SCRIPT ;\n#;;;;;;;;;;;;;;;;;;\n/" \
	| sed  -e "s/listen=NO/listen=YES/"  \
	| sed -e "s/#write_enable=YES/write_enable=YES/"  \
	| sed -e "s/ssl_enable=NO/ssl_enable=YES/"  \
	> $output 
   

}


enableFtpServiceStart() {
	#enable service and start
	systemctl start vsftpd
	systemctl enable vsftpd

	 #service vsftpd reload
}