#!/bin/sh

if [ -d /data/mysql ]; then
  echo "[i] MySQL directory already present, skipping creation"
else
  echo "[i] MySQL data directory not found, creating initial DBs"
  mkdir -p /data/mysql/ /data/mysql/data/ /data/mysql/logs/
  chown -R mysql:mysql /data/mysql/
  mysql_install_db --user=mysql --datadir=/data/mysql/data/ > /dev/null
  
  if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
    MYSQL_ROOT_PASSWORD=111111
    echo "[i] MySQL root Password: $MYSQL_ROOT_PASSWORD"
  fi
  
### Set Defaults
  MYSQL_DATABASE=${MYSQL_DATABASE:-""}
  MYSQL_USER=${MYSQL_USER:-""}
  MYSQL_PASSWORD=${MYSQL_PASSWORD:-"111111"}

### Update for Zabbix Monitoring
sed -i -e "s/<ROOT_PASSWORD>/$MYSQL_PASSWORD/g" /etc/zabbix/.my.cnf
chmod 0700 /etc/zabbix/.my.cnf

  if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
  fi

  tfile=`mktemp`
  if [ ! -f "$tfile" ]; then
      return 1
  fi

  cat << EOF > $tfile
DELETE FROM mysql.user ;
USE mysql;
FLUSH PRIVILEGES;
CREATE USER 'root'@'127.0.0.1' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
CREATE USER 'root'@'172.17.0.%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
CREATE USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
GRANT ALL ON *.* TO 'root'@'127.0.0.1' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'172.17.0.%' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION ;
DROP DATABASE IF EXISTS test ;
create user zabbix@'127.0.0.1' identified by 'zabbix';
create user zabbix@'172.17.0.%' identified by 'zabbix';
create database zabbix char set utf8;
grant all on zabbix.* to zabbix@'127.0.0.1';
grant all on zabbix.* to zabbix@'172.17.0.%';
FLUSH PRIVILEGES;
EOF

  if [ "$MYSQL_DATABASE" != "" ]; then
    echo "[i] Creating database: $MYSQL_DATABASE"
    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

    if [ "$MYSQL_USER" != "" ]; then
      echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
      echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
    fi
  fi

  /usr/bin/mysqld --user=mysql --bootstrap --datadir=/data/mysql/data/ --verbose=0 < $tfile
  rm -f $tfile
fi


exec /usr/bin/mysqld --user=mysql --datadir=/data/mysql/data --console &
sleep 5
/usr/bin/mysql -uroot -D zabbix -p"${MYSQL_ROOT_PASSWORD}" < "/mysql/zabbix.sql"
ping 127.0.0.1 >> /dev/null
