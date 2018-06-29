FROM aqzt/docker-alpine
LABEL maintainer="aqzt.com (ppabc@qq.com)"

# webproc release settings
ENV HTTP_USER user
ENV HTTP_PASS Root123
ENV WEBPROC_VERSION 0.1.9
ENV WEBPROC_URL https://github.com/jpillora/webproc/releases/download/$WEBPROC_VERSION/webproc_linux_amd64.gz
# fetch dnsmasq and webproc binary
RUN apk update \
	&& apk --no-cache add dnsmasq \
	&& apk add --no-cache --virtual .build-deps curl \
	&& curl -sL $WEBPROC_URL | gzip -d - > /usr/local/bin/webproc \
	&& chmod +x /usr/local/bin/webproc \
	&& apk del .build-deps
#configure dnsmasq
run mkdir -p /etc/default/
RUN echo -e "ENABLED=1\nIGNORE_RESOLVCONF=yes" > /etc/default/dnsmasq

EXPOSE 53/tcp 53/udp

ADD root /
