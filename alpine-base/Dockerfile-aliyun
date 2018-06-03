FROM alpine:3.7
LABEL maintainer="ppabc (ppabc@qq.com)"
RUN echo "https://mirrors.aliyun.com/alpine/v3.7/main" > /etc/apk/repositories
RUN echo "https://mirrors.aliyun.com/alpine/v3.7/community" >> /etc/apk/repositories

### Set Defaults
    ARG S6_OVERLAY_VERSION=v1.21.2.2 
    ENV DEBUG_MODE=FALSE \
        ENABLE_CRON=FALSE \
        ENABLE_SMTP=FALSE \
        ENABLE_ZABBIX=FALSE

### Add Zabbix User First
        RUN set -x ; \
        addgroup -g 10050 zabbix ; \
        adduser -S -D -H -h /dev/null -s /sbin/nologin -G zabbix -u 10050 zabbix ;\
        
### Install MailHog
        apk --no-cache add --virtual mailhog-build-dependencies \
                go \
                git \
                musl-dev \
                ; \
       mkdir -p /usr/src/gocode ; \
       export GOPATH=/usr/src/gocode ; \
       go get github.com/mailhog/MailHog ; \
       go get github.com/mailhog/mhsendmail ; \
       mv /usr/src/gocode/bin/MailHog /usr/local/bin ; \
       mv /usr/src/gocode/bin/mhsendmail /usr/local/bin ; \
       rm -rf /usr/src/gocode ; \
       apk del --purge mailhog-build-dependencies ; \
       adduser -S -D -H -h /dev/null -u 1025 mailhog ; \

### Add Core Utils
       apk --no-cache upgrade ; \
       apk --no-cache add \
            bash \
            curl \
            grep \
            less \
            logrotate \
            msmtp \
            nano \
            sudo \
            tzdata \
            vim \
            zabbix-agent \
            zabbix-utils \
            ; \
       rm -rf /var/cache/apk/* ; \
       rm -rf /etc/logrotate.d/acpid ; \
       cp -R /usr/share/zoneinfo/Asia/Shanghai /etc/localtime ; \
       echo 'Asia/Shanghai' > /etc/timezone ; \
       echo '%zabbix ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers ; \

### S6 Installation
       curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar xfz - -C / ; \
   
### Add Folders
       mkdir -p /assets/cron

   ADD root /

### Networking Configuration
   EXPOSE 1025 8025 10050/TCP 

### Entrypoint Configuration
   ENTRYPOINT ["/init"]
