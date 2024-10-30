#!/bin/bash


#https://github.com/tlissak/settings/blob/main/doc/postfix.md

apt-get -qy install libdb5.1 postfix procmail sasl2-bin
echo "[smtp-relay.sendinblue.com]:587 USERNAME:API_KEY\n[smtp.gmail.com]:587 username@gmail.com:password" >> /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd
chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
chmod 0600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db

nano /etc/postfix/main.cf

relayhost = [smtp-relay.sendinblue.com]:587
smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated defer_unauth_destination
smtp_sasl_password_maps=hash:/etc/postfix/sasl_passwd
smtp_sasl_auth_enable = yes
smtp_sasl_mechanism_filter = plain, login
smtp_sasl_security_options = noanonymous
smtp_use_tls = yes

service postfix restart


sudo apt-get install mailutils  
echo  "body of your email" | mail -s "This is a subject" -a "From: glasman.fr@gmail.com" tlissak@gmail.com