FROM aqzt/docker-alpine
LABEL maintainer="aqzt.com (ppabc@qq.com)"

ENV ROOT_PASSWORD root

RUN apk update	&& apk upgrade && apk add openssh \
		&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
		&& echo "root:${ROOT_PASSWORD}" | chpasswd \
		&& rm -rf /var/cache/apk/* /tmp/*

EXPOSE 22

ADD root /
