LocalNode is the node the stay
RemovalNode is the node that goes away

don't shutdown the RemovalNode

Use ssh cli (putty?) NOT the one in the GUI

in LocalNode run to liste nodes
```
pvecm nodes 
```
then run 
```
pvecm delnode "RemovalNode-Name"
rm -r /etc/pve/nodes/RemovalNode-Name
```
this should remove the node

```
pvecm expected 1
systemctl restart pve-cluster
```

in the RemovalNode connect with new ssh cli 
and run the following commandes the detache it from the cluster :
```
systemctl stop pve-cluster corosync
pmxcfs -l
rm /etc/corosync/*
rm /etc/pve/corosync.conf
killall pmxcfs
systemctl start pve-cluster
```
