#!/bin/bash

set -e
apt-get install -y vsftpd

cp --backup=numbered /etc/vsftpd.conf /etc/vsftpd.conf.bak

cp vsftpd.conf /etc/vsftpd.conf


/etc/init.d/vsftpd start
systemctl enable vsftpd
systemctl start vsftpd

service vsftpd reload
service vsftpd restart

#apt-get remove -y vsftpd
#rm /etc/vsftpd.conf
