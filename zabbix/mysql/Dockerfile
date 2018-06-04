FROM ppabc/alpine:3.7m
LABEL maintainer="aqzt.com (ppabc@qq.com)"

RUN echo "https://mirrors.aliyun.com/alpine/v3.7/main" > /etc/apk/repositories
RUN echo "https://mirrors.aliyun.com/alpine/v3.7/community" >> /etc/apk/repositories

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
