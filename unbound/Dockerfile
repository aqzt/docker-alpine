FROM aqzt/docker-alpine
LABEL maintainer="aqzt.com (ppabc@qq.com)"

### Disable Features from Base Image
   ENV ENABLE_CRON=FALSE \
       ENABLE_SMTP=FALSE

### Install Dependencies
   RUN apk update && \
       apk add \
           unbound && \

### Configure Unbound
       curl ftp://ftp.internic.net/domain/named.cache > /etc/unbound/root.hints


### Add Files
   ADD root /

### Networking Configuration
   EXPOSE 53
