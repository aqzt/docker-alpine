#!/bin/sh

    DOCKER_IP=$(ip a|grep "inet "|awk -F" " '{print $2}'|awk -F"/" '{print $1}'|egrep "^172" |head -n 1)
    ZABBIX_SERVER_ACTIVE=${ZABBIX_SERVER_ACTIVE:-"172.17.0.2"}
    ZABBIX_HOSTNAME=${ZABBIX_HOSTNAME:-"$DOCKER_IP"}
    DBHOST=${DBHOST:-"127.0.0.1"}
    DBPORT=${DBPORT:-"3306"}
    DBUSER=${DBUSER:-"zabbix"}
    DBPASSWORD=${DBPASSWORD:-"zabbix"}

    sed -i ''/DBHost=/a\DBHost=$DBHOST'' /etc/zabbix/zabbix_server.conf
    sed -i ''/DBPort=/a\DBPort=$DBPORT'' /etc/zabbix/zabbix_server.conf
    sed -i ''/DBUser=/a\DBUser=$DBUSER'' /etc/zabbix/zabbix_server.conf
    sed -i ''/DBPassword=/a\DBPassword=$DBPASSWORD'' /etc/zabbix/zabbix_server.conf
    sed -i "s/DBHost/$DBHOST/g" /var/www/localhost/htdocs/conf/zabbix.conf.php
    sed -i "s/DBPort/$DBPORT/g" /var/www/localhost/htdocs/conf/zabbix.conf.php
    sed -i "s/DBUSER/$DBUSER/g" /var/www/localhost/htdocs/conf/zabbix.conf.php
    sed -i "s/DBPASSWORD/$DBPASSWORD/g" /var/www/localhost/htdocs/conf/zabbix.conf.php
sed -i "s/<ZABBIX_SERVER_ACTIVE>/$ZABBIX_SERVER_ACTIVE/g" /etc/zabbix/zabbix_agentd.conf
sed -i "s/<ZABBIX_HOSTNAME>/$ZABBIX_HOSTNAME/g" /etc/zabbix/zabbix_agentd.conf

/usr/sbin/httpd
##/usr/sbin/zabbix_agentd
su -p -s /bin/sh zabbix -c "/usr/sbin/zabbix_server -f"
ping 127.0.0.1 >> /dev/null
