#!/bin/sh

set -ex

if [ ! -d "/var/lib/mysql/mysql" ]; then
	#install mariadb table
	mysql_install_db

	#start mariadb
	service mariadb start
	sleep 2

	#creates the command with root flags
	mysql="mysql -uroot -hlocalhost"

	#pass heredoc file as command lines to the mysql command
	$mysql <<- EOSQL
		DELETE FROM mysql.user WHERE user NOT IN ('mariadb.sys', 'root') OR host NOT IN ('localhost') ;
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
		GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION ;
		DROP DATABASE IF EXISTS test ;
		CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\` ;
		CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}' ;
		GRANT ALL ON \`${MARIADB_DATABASE}\`.* TO '${MARIADB_USER}'@'%' ;
		FLUSH PRIVILEGES ;
	EOSQL

	#add flags to the command
	mysql="${mysql} -p${MARIADB_ROOT_PASSWORD} ${MARIADB_DATABASE}"
	#add wordpress database already preconfigured
	${mysql} < wordpress.sql

	#stop mariadb before launching mysqld
	mariadb-admin -p${MARIADB_ROOT_PASSWORD} shutdown
fi

#replace shell with current execution instead of exiting
exec "$@"