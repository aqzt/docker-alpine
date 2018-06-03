FROM aqzt/docker-alpine
LABEL maintainer="aqzt.com (ppabc@qq.com)"

ENV MAINLAND Y

ADD root /
RUN chmod +x /zabbix/install.sh  && chmod +x /zabbix/startup.sh && sh /zabbix/install.sh

EXPOSE 80 443 10050 10051

CMD /zabbix/startup.sh
