Disable password prompt evreytime :
----

Run command:
```ssh
sudo visudo
```
 add the following line:
 ```
<user> ALL=(ALL) NOPASSWD: ALL
```
Note: replace <user> with your username

Save and exit the file
Run command:
```
sudo -k
```
This will clear the exiting password cache
You're done

To test, run command:
```
sudo ls
```
You should not be prompted for a password






Enable SSH 
----

Enable ssh to be logged remotely :

Install ssh server via :
```
sudo apt install openssh-server -y
```


install my wifi Adapter 
----
```
sudo apt install build-essential git
git clone https://github.com/gnab/rtl8812au.git
cd rtl8812au
make
sudo make install
sudo modprobe 8812au
```