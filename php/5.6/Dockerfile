FROM aqzt/docker-alpine
LABEL maintainer="aqzt.com (ppabc@qq.com)"

### Default Runtime Environment Variables
  ENV ZABBIX_HOSTNAME=nginx-php-fpm-app \
      ENABLE_SMTP=TRUE

   ADD root /
   RUN /tmp/install.sh

### Networking Configuration
  EXPOSE 80 443

### Files Addition
  RUN chmod +x /etc/zabbix/zabbix_agentd.conf.d/scripts/*
