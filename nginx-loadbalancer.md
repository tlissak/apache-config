```
apt-get -y install nginx 
```

```
nano /etc/nginx/conf.d/loadbalance.conf
```

```
upstream backend {
  server 192.168.0.56;
  server 192.168.0.57;
}


server {
    listen 80;
    server_name 192.168.0.84 .yourdomain.name;
    location / {
        proxy_pass http://backend;
    }
}
```


now test configuraion :
```
nginx -t 
```
if ok :
```
service nginx reload
```
