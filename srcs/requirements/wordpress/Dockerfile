FROM debian:bullseye

RUN	set -ex; \
	apt-get update -y; \
	apt-get upgrade -y; \
	apt-get install -y wget; \
	apt-get install -y wordpress php-fpm; \
	apt-get install -y less; \
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
	chmod +x wp-cli.phar; \
	mv wp-cli.phar /usr/local/bin/wp; \
	mkdir -p /run/php

WORKDIR /var/www/html

RUN set -ex; \
	wget http://wordpress.org/latest.tar.gz; \
	tar -xvzf latest.tar.gz && rm latest.tar.gz; \
	mv wordpress/* ./ && rm -r wordpress

COPY conf/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "sh", "/entrypoint.sh" ]

#CMD tail -f > /dev/null

CMD ["php-fpm7.4", "-F"]
