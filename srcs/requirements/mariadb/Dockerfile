FROM debian:bullseye

#keep trace of exeuted commands and exit if one fails
RUN	set -ex; \
	#create a user and a group
	groupadd -r mysqlgp && useradd -r -g mysqlgp mysqlusr; \
	#update and upgrade package list
	apt-get -y update; \
	apt-get upgrade -y; \
	#insatall mariadb server package
	apt-get install -y mariadb-server; \
	#purge and recreate datadir with appropriate ownership to get rid of default
	rm -rf /var/lib/mysql; \
	mkdir -p /var/lib/mysql /var/run/mysqld; \
	chown -R mysqlusr:mysqlgp /var/lib/mysql /var/run/mysqld; \
	#make shure /var/run/mysqld (used for socket) is writable
	chmod 777 /var/run/mysqld; \
	#comment address binding default to allow connections from any address
	sed -i 's/^(bind-address)/#&/' /etc/mysql/mariadb.conf.d/50-server.cnf;

#copy the entrypoint script that will configure mariadb and the wordpress database
COPY tools/entrypoint.sh /entrypoint.sh
COPY conf/wordpress.sql /wordpress.sql

#make shure it is executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]
