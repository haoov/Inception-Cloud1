#load the image from docker hub
FROM debian:bullseye

RUN	set -ex; \
	#update package and install utilitys
	apt-get update -y; \
	apt-get upgrade -y; \
	apt-get install nginx -y openssl; \
	#generate key and certificate
	mkdir -p /etc/nginx/ssl; \
	openssl req -x509 -nodes -keyout /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.cert -subj "/CN=rsabbah.42.fr"

#copy conf file for nginx
COPY conf/server.conf /etc/nginx/conf.d/server.conf

#launch nginx
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
