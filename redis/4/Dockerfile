FROM aqzt/docker-alpine
LABEL maintainer="aqzt.com (ppabc@qq.com)"

	ENV REDIS_VERSION=4.0.9 \
	    REDIS_DOWNLOAD_URL=http://download.redis.io/releases/redis-4.0.9.tar.gz \
	    ZABBIX_HOSTNAME=redis-db \
        ENABLE_SMTP=FALSE

## Redis Installation
	RUN set -x ; \
	    addgroup -S -g 6379 redis ; \
            adduser -S -D -H -h /dev/null -s /sbin/nologin -G redis -u 6379 redis ;\

	    apk add --no-cache 'su-exec>=0.2' ; \
	    set -ex ; \
		\
		apk add --no-cache --virtual .redis-build-deps \
			gcc \
			linux-headers \
			make \
			musl-dev \
			tar \
		    ; \
		mkdir -p /usr/src/redis ; \
		curl $REDIS_DOWNLOAD_URL | tar xfz - --strip 1 -C /usr/src/redis ; \
		
		grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 1$' /usr/src/redis/src/server.h ; \
		sed -ri 's!^(#define CONFIG_DEFAULT_PROTECTED_MODE) 1$!\1 0!' /usr/src/redis/src/server.h ; \
		grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 0$' /usr/src/redis/src/server.h ; \
		
		make -C /usr/src/redis ; \
		make -C /usr/src/redis install ; \
		
		rm -r /usr/src/redis ; \
		
		apk del .redis-build-deps ; \
        rm -rf /var/cache/apk/* ; \

# Workspace and Volume Setup
        mkdir -p /data ; \
        chown redis /data

    VOLUME /data
    WORKDIR /data

## Networking Configuration
    EXPOSE 6379

### Files Addition
   ADD root /
