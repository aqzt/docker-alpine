FROM aqzt/docker-alpine
LABEL maintainer="aqzt.com (ppabc@qq.com)"

ADD root /
RUN chmod +x /mysql/install.sh  && chmod +x /mysql/startup.sh && sh /mysql/install.sh

EXPOSE 3306

CMD ["/mysql/startup.sh"]
