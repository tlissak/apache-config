

nano /etc/ssh/sshd_config
PermitRootLogin yes
service sshd restart


remove php
apt-get -y purge php8.*