#!/bin/sh
/usr/sbin/httpd
#/usr/sbin/zabbix_agentd
su -p -s /bin/sh zabbix -c "/usr/sbin/zabbix_server -f"
