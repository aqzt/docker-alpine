FROM aqzt/docker-alpine:zabbix-agentd
LABEL maintainer="aqzt.com (ppabc@qq.com)"

ENV ENABLE_ZABBIX=TRUE

   RUN set -x ; \
       mkdir -p /var/lib/mysql/ /run/mysqld /data/mysql/data/ /data/mysql/logs/ ; \
       addgroup -g 82 -S mysql ; \
       adduser -u 82 -D -S -G mysql mysql ; \
       chown -R mysql:mysql /data/mysql ; \
       chown -R mysql:mysql /run/mysqld ; \
       chmod 777 /tmp
    
   RUN apk add --update mariadb mariadb-client zabbix-agent zabbix-utils ; \
       rm -f /var/cache/apk/*
    
ADD root /

EXPOSE 3306

CMD ["/mysql/startup.sh"]
