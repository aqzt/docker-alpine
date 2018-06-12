FROM aqzt/docker-alpine:glibc
LABEL maintainer="aqzt.com (ppabc@qq.com)"

ENV JAVA_HOME /usr/lib/jvm/jre
ENV PATH $PATH:$JAVA_HOME/bin

RUN apk add --no-cache --virtual=build-dependencies wget ca-certificates \
  && mkdir /usr/lib/jvm \
  && cd /usr/lib/jvm \
  && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/server-jre-8u171-linux-x64.tar.gz -O - | gunzip | tar x \
  && ln -s /usr/lib/jvm/jdk1.8.0_171 /usr/lib/jvm/jre \
  && apk del build-dependencies \
  && rm -rf /tmp/*
