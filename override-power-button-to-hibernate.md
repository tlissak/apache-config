WORK 

nano /etc/systemd/logind.conf

Add this line :

HandlePowerKey=poweroff

call this or reboot 
systemctl restart systemd-logind

source : https://askubuntu.com/questions/362914/how-to-prevent-the-power-button-to-shutdown-directly-the-system

DOSNT WORK : 
1. Install acpid deamon
```
apt-get -y install acpid 
```

2. create handler for power button with the content below
```
nano /etc/acpi/events/power
```
```
event=button/power
action=/etc/acpi/power.sh "%e"
```
Save

3. Write action script for the trigger when button power is triggerd it the action of hybernate (can be sleep or hybrid check the documentation)
```
nano /etc/acpi/power.sh
```
```
#!bin/sh
systemctl hibernate
```
save 

4. Enable the service acpid on boot
```
systemctl enable --now acpid
```
