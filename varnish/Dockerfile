FROM aqzt/docker-alpine
LABEL maintainer="aqzt.com (ppabc@qq.com)"

RUN apk --update upgrade && apk add varnish

ADD root /

EXPOSE 80 81


