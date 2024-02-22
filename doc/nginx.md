download lastest from :
http://nginx.org/en/download.html

conf/nginx.conf : 


	worker_processes  1;
	
	
	# https://blog.madrzejewski.com/offloader-ssl-nginx-reverse-proxy-apache/
	
	events {
	    worker_connections  1024;
	}
	
	http {
	
		server {
	        listen       80;		
	        server_name  yourservername.com www.yourservername.com;
	
			location / {
				proxy_pass http://localhost:8888;
				proxy_set_header X-Real-IP $remote_addr;
				proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			}
		}
	 
		server {
		
			listen 443 ssl;		
			
			http2  on;
			
	        server_name  yourservername.com www.yourservername.com;
	
			
			    ssl_certificate "C:/apms/httpd-2.4.54-o305-x64-vs17/Apache24/conf/ssl/certificate_and_bundle.crt";		
	      # file is merging : first is the certificate second the bundle certificate 
	        ssl_certificate_key "C:/apms/httpd-2.4.54-o305-x64-vs17/Apache24/conf/ssl/private.key";	
					
	        ssl_session_cache shared:SSL:1m;
	        ssl_session_timeout  10m;
	        ssl_ciphers HIGH:!aNULL:!MD5;
	        ssl_prefer_server_ciphers on;
	
	        location / {
	            proxy_set_header Host $host;            
				      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	            proxy_set_header X-Forwarded-Proto https;
	            proxy_set_header X-Forwarded-Port 443;			
				      proxy_pass http://localhost:8888;
		   }
		}
	}


install as service 
https://blog.codingblob.info/blog/lancer-nginx-en-tant-que-service-windows

download stable !! version : 
https://github.com/winsw/winsw/releases

**rename** the winsw-x86.exe to the name of the service "nginx-service.exe"

then create xml file name "nginx-service.xml" :

    <service>
      <id>apms_nginx</id>
      <name>apms_nginx</name>
      <description>Serveur web Nginx</description>
      <executable>c:\path_to_your_file\nginx-1.25.4\nginx.exe</executable>
      <logpath>c:\path_to_your_file\nginx-1.25.4\</logpath>
      <logmode>roll</logmode>
      <depend></depend>
      <startargument>-p</startargument>
      <startargument>c:\path_to_your_file\nginx-1.25.4\</startargument>
      <stopexecutable>c:\path_to_your_file\nginx-1.25.4\killall-nginx.bat</stopexecutable>
    </service>

create bat file "killall-nginx.bat"

    nginx-1.25.4\nginx.exe -p nginx-1.25.4/ -s stop
    taskkill /IM nginx.exe /F /T

lunch from cmd  :
`
nginx-service.exe install
`
