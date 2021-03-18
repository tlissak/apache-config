
## postfix as relay https://www.linode.com/docs/guides/postfix-smtp-debian7/

be root :

```
sudo su
```

```
sudo apt-get install libdb5.1 postfix procmail sasl2-bin
```
Choose to install postfix as internet server
```
nano /etc/postfix/sasl_passwd
```
```
[smtp-relay.sendinblue.com]:587 USERNAME:API_KEY
[smtp.gmail.com]:587 username@gmail.com:password
```
```
postmap /etc/postfix/sasl_passwd
```
```
chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
chmod 0600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
```
```
nano /etc/postfix/main.cf
```

```
relayhost = [smtp-relay.sendinblue.com]:587
smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated defer_unauth_destination
smtp_sasl_password_maps=hash:/etc/postfix/sasl_passwd
smtp_sasl_auth_enable = yes
smtp_sasl_mechanism_filter = plain, login
smtp_sasl_security_options = noanonymous
smtp_use_tls = yes
```

```
service postfix restart
```

## Email testing
```
sudo apt-get install mailutils  
echo  "body of your email" | mail -s "This is a subject" -a "From: glasman.fr@gmail.com" tlissak@gmail.com
```
debug :
```
nano /var/log/mail.log
```     
