#!/bin/sh

set -x \
	&& mkdir -p /var/lib/mysql/ /run/mysqld /data/mysql/data/ /data/mysql/logs/ \
	&& addgroup -g 82 -S mysql \
	&& adduser -u 82 -D -S -G mysql mysql \
	&& chown -R mysql:mysql /data/mysql \
	&& chown -R mysql:mysql /run/mysqld \
	&& chmod 777 /tmp
	
apk add --update mariadb mariadb-client && rm -f /var/cache/apk/*
cp /mysql/my.cnf /etc/mysql/my.cnf
