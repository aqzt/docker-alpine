FROM aqzt/docker-alpine
LABEL maintainer="aqzt.com (ppabc@qq.com)"

    ENV MARIADB_VER=10.2.14 \
        ZABBIX_HOSTNAME=mariadb-db \
        ENABLE_SMTP=FALSE

   ADD root /
   RUN /tmp/install.sh

### Networking
   EXPOSE 3306

