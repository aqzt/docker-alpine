FROM aqzt/docker-alpine:mini
LABEL maintainer="aqzt.com (ppabc@qq.com)"

   RUN set -x ; \
       mkdir -p /var/lib/mysql/ /run/mysqld /data/mysql/data/ /data/mysql/logs/ ; \
       addgroup -g 82 -S mysql ; \
       adduser -u 82 -D -S -G mysql mysql ; \
       chown -R mysql:mysql /data/mysql ; \
       chown -R mysql:mysql /run/mysqld ; \
       chmod 777 /tmp
    
   RUN apk add --update mariadb mariadb-client  ; \
       rm -f /var/cache/apk/*
    
ADD root /

EXPOSE 3306

CMD ["/etc/s6/services/10-mariadb/run"]
