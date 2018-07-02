FROM aqzt/docker-alpine
LABEL maintainer="aqzt.com (ppabc@qq.com)"

RUN apk --update upgrade && apk add bind

RUN mkdir -m 0770 -p /etc/bind && chown -R root:named /etc/bind ; \
    mkdir -m 0770 -p /var/cache/bind && chown -R root:named /var/cache/bind ; \
    wget -q -O /etc/bind/bind.keys https://ftp.isc.org/isc/bind9/keys/9.11/bind.keys.v9_11 ; \
    rndc-confgen -a -r /dev/urandom

ADD root /

VOLUME ["/etc/bind"]
VOLUME ["/var/cache/bind"]

EXPOSE 53/tcp 53/udp


