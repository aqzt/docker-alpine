FROM aqzt/docker-alpine
LABEL maintainer="aqzt.com (ppabc@qq.com)"

## Set Environment Variables
	ARG MEMCACHED_VERSION=1.5.4
	ARG MEMCACHED_SHA1=29cb75cc234dbaceed6e89db029af8363706f0fe
        ENV ZABBIX_HOSTNAME=memcached-app

## Install
# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
	RUN adduser -D memcache ; \

	    set -x ; \
		apk add --no-cache --virtual .build-deps \
			ca-certificates \
			coreutils \
			cyrus-sasl-dev \
			dpkg-dev dpkg \
			gcc \
			libc-dev \
			libevent-dev \
			libressl \
			linux-headers \
			make \
			perl \
			tar \
	        ; \
               
            apk add --no-cache \
                python \
                ; \

		wget -O memcached.tar.gz "https://memcached.org/files/memcached-$MEMCACHED_VERSION.tar.gz" ; \
		echo "$MEMCACHED_SHA1  memcached.tar.gz" | sha1sum -c - ; \
		mkdir -p /usr/src/memcached ; \
		tar -xzf memcached.tar.gz -C /usr/src/memcached --strip-components=1 ; \
		rm memcached.tar.gz ; \
		cd /usr/src/memcached ; \
		./configure \
			--build="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
			--enable-sasl ; \
		make -j "$(nproc)" ; \
		make install ; \
		cd / && rm -rf /usr/src/memcached ; \
		runDeps="$( \
			scanelf --needed --nobanner --recursive /usr/local \
				| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
				| sort -u \
				| xargs -r apk info --installed \
				| sort -u \
		)" ; \
		apk add --virtual .memcached-rundeps $runDeps ; \
		apk del .build-deps ; \
                rm -rf /var/cache/apk/*	; \
		memcached -V

   
### Add Folders
    ADD /root /

## Networking Setup
	EXPOSE 11211

