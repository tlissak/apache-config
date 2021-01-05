Windows time sync issue at logon
---
In file explorer go to : 
```
C:\Windows\System32\GroupPolicy\Machine\Scripts\Startup
```
Create new batch file like : timesync.bat 

```
@echo off
sc config w32time start=auto
net stop w32time
net start w32time
W32tm /config /manualpeerlist:pool.ntp.org /syncfromflags:MANUAL
W32tm /config /update
w32tm /resync /rediscover
```

to check if is appalied run 
```
run gpedit.msc 
```
under 
```
Computer Configuration / Windows Settings / Scripts (Startup/Shutdown) 
```
double click to check if it shows up
