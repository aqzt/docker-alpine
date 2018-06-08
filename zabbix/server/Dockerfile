FROM aqzt/docker-alpine:zabbix-agentd
LABEL maintainer="aqzt.com (ppabc@qq.com)"

ADD root /

RUN apk update && \
    apk add php7-apache2 php7-session php7-mysqli php7-mbstring sudo && \
    apk add zabbix zabbix-mysql zabbix-webif zabbix-setup zabbix-utils && \
    apk add coreutils net-snmp net-snmp-tools zabbix-agent mysql-client nmap && \
    sed -i 's/max_execution_time = 30/max_execution_time = 600/g' /etc/php7/php.ini && \
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php7/php.ini && \
    sed -i '/;date.timezone =/a\date.timezone = PRC' /etc/php7/php.ini && \
    sed -i 's/post_max_size = 8M/post_max_size = 32M/g' /etc/php7/php.ini && \
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 16M/g' /etc/php7/php.ini && \
    sed -i 's/memory_limit = 128M/memory_limit = 256M/g' /etc/php7/php.ini && \
    sed -i 's/max_input_time = 60/max_input_time = 300/g' /etc/php7/php.ini && \
    sed -i '/;always_populate_raw_post_data = -1/a\always_populate_raw_post_data = -1' /etc/php7/php.ini && \
    sed -i '/FpingLocation=/a\FpingLocation=/usr/sbin/fping' /etc/zabbix/zabbix_server.conf && \
    mkdir -p /run/apache2 && \
    chown -R apache /run/apache2 && \
    rm /var/www/localhost/htdocs -R && \
    mv /zabbix/msyh.ttf /usr/share/webapps/zabbix/fonts/ && \
    ln -s /usr/share/webapps/zabbix /var/www/localhost/htdocs && \
    mv /zabbix/zabbix.conf.php /var/www/localhost/htdocs/conf/ && \
    chown -R apache /usr/share/webapps/zabbix/conf && \
    addgroup zabbix readproc && \
    chown -R zabbix /var/log/zabbix && \
    chown -R zabbix /var/run/zabbix && \
    echo "zabbix ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/zabbix && \
    sed -i "s/DejaVuSans/msyh/"  /usr/share/webapps/zabbix/include/defines.inc.php && \
    sed -i "s/Listen 80/Listen 8080/"  /etc/apache2/httpd.conf

EXPOSE 8080 443 10050 10051

CMD ["/zabbix/startup.sh"]
