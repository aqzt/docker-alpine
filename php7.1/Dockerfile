FROM ppabc/docker-alpine:alpine
LABEL maintainer="ppabc (ppabc@qq.com)"

### Default Runtime Environment Variables
  ENV ZABBIX_HOSTNAME=nginx-php-fpm-app \
      ENABLE_SMTP=TRUE

   ADD root /
   RUN /tmp/install.sh

### Networking Configuration
  EXPOSE 80

### Files Addition
  ADD root /
  RUN chmod +x /etc/zabbix/zabbix_agentd.conf.d/scripts/*
