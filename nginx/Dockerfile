FROM ppabc/docker-alpine:alpine
LABEL maintainer="ppabc (ppabc@qq.com)"

### Set Nginx Version Number
   ARG NGINX_VERSION=1.14.0

   ADD root /
   RUN /tmp/install.sh

### Networking Configuration
  EXPOSE 80 443

### Files Addition
  RUN chmod +x /etc/zabbix/zabbix_agentd.conf.d/scripts/*

