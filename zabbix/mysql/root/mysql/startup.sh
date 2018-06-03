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

  MYSQL_DATABASE=${MYSQL_DATABASE:-""}
  MYSQL_USER=${MYSQL_USER:-""}
  MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

  if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
  fi

  tfile=`mktemp`
  if [ ! -f "$tfile" ]; then
      return 1
  fi

  cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("$MYSQL_ROOT_PASSWORD") WHERE user='root' AND host='localhost';
create user zabbix@'127.0.0.1' identified by 'zabbix';
create user zabbix@localhost identified by 'zabbix';
create database zabbix char set utf8;
grant all on zabbix.* to zabbix@'127.0.0.1';
grant all on zabbix.* to zabbix@localhost;
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
  /usr/bin/mysqld --user=mysql --bootstrap --datadir=/data/mysql/data/ --verbose=0 < "/mysql/zabbix.sql"
  rm -f $tfile
fi

exec /usr/bin/mysqld --user=mysql --datadir=/data/mysql/data --console &
##sleep 20
##/usr/bin/mysql -uroot -D zabbix -p"111111" < "/mysql/zabbix.sql"
ping 127.0.0.1 >> /dev/null
