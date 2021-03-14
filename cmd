docker build -t <nom image> .

docker run -d -p 80:80 -p 443:443 <nom image>

docker exec -it <id container> <commande>

docker ps 

docker ps -a

docker rm -f <container id>
delete all containers :
docker rm $(docker ps -a -q)

docker stop $(docker ps -a -q)

docker image ls

docker image rm


stopper nginx
ps -ef |grep nginx
kill -9 [pid]




vieille config

#http {
#	include                     /etc/nginx/mime.types;
#	default_type                application/octet-stream;
#	sendfile                    on;
#	access_log                  /var/log/nginx/access.log;
#	keepalive_timeout           3000;
#	server {
#		listen                  80;
#		listen                  443 ssl;
#
#		ssl_certificate			/etc/ssl/certs/ssl_nginx.certs
#		ssl_certificate			/etc/ssl/certs/private/ssl_nginx.key
#
#		root                    /www;
#		index                   index.html index.htm;
#		server_name             localhost;
#		client_max_body_size    32m;
#		error_page              500 502 503 504  /50x.html;
#		location = /50x.html {
#			  root              /var/lib/nginx/html;
#		}
#	}
#}