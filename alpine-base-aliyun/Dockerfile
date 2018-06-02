FROM alpine:3.7
LABEL maintainer="ppabc (ppabc@qq.com)"
RUN echo "https://mirrors.aliyun.com/alpine/v3.7/main" > /etc/apk/repositories
RUN echo "https://mirrors.aliyun.com/alpine/v3.7/community" >> /etc/apk/repositories

### Set Defaults
    ARG S6_OVERLAY_VERSION=v1.21.2.2 
    ENV DEBUG_MODE=FALSE \
        ENABLE_CRON=TRUE \
        ENABLE_SMTP=TRUE \
        ENABLE_ZABBIX=FALSE

   ADD root /
   RUN /tmp/install.sh

### Networking Configuration
   EXPOSE 1025 8025 10050/TCP 

### Entrypoint Configuration
   ENTRYPOINT ["/init"]
