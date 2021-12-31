#!/bin/bash
sudo apt-get install libdb5.1 postfix procmail sasl2-bin
echo "[smtp-relay.sendinblue.com]:587 USERNAME:API_KEY\n[smtp.gmail.com]:587 username@gmail.com:password" >> /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd
chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
chmod 0600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db

# /etc/postfix/main.cf