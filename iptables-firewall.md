apt install iptables


# Accept everything on the loopback interface
iptables -A INPUT -i lo -j ACCEPT

# Accept ICMP
iptables -A INPUT -p icmp --icmp-type any -j ACCEPT

# Drop oddball packets
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
iptables -A INPUT -f -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP

# Accept packets that are part of established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#iptables -I OUTPUT -m state --state ESTABLISHED,RELATED,NEW -j ACCEPT

# Accept selected incoming connections, port 3361 from local network 192.168.0.x
iptables -A INPUT -p tcp --dport 3361 -s 192.168.0.0/24 -j ACCEPT

 
# Reject incoming connections that aren't explicitly accepted
iptables -A INPUT -j REJECT


sudo sh -c 'iptables-save > /etc/iptables/rules.v4'


apt install iptables-persistent

iptables -P INPUT DROP
