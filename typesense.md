```

# version is 27.1

apt update && apt upgrade -y
apt install curl

curl -O https://dl.typesense.org/releases/27.1/typesense-server-27.1-amd64.deb
apt install ./typesense-server-27.1-amd64.deb

echo 'enable-cors = true' >> /etc/typesense/typesense-server.ini

```

http://192.168.0.64:8108
