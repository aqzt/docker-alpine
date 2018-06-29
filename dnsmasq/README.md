## 基于Alpine系统的dnsmasq镜像

### 概述
使用Dockerfile构建基于Alpine系统的dnsmasq镜像,并采用supervise守护进程。

### 使用说明
```

docker run --name dnsmasq -d -p 53:53/udp -p 8080:8080 -v /opt/dnsmasq.conf:/etc/dnsmasq.conf --log-opt "max-size=100m" -e "HTTP_USER=user" -e "HTTP_PASS=Root123" --restart always aqzt/docker-alpine:dnsmasq
或者
docker run -d --name dnsmasq -ti -p 53:53/udp -p 8080:8080 -v /opt/dnsmasq.conf:/etc/dnsmasq.conf --log-opt "max-size=100m"   -e "HTTP_USER=user" -e "HTTP_PASS=Root123" aqzt/docker-alpine:dnsmasq
或者采用host方式
docker run -d --name dnsmasq -it --net=host -v /opt/dnsmasq.conf:/etc/dnsmasq.conf --log-opt "max-size=100m"   -e "HTTP_USER=user" -e "HTTP_PASS=Root123"  aqzt/docker-alpine:dnsmasq

```

使用docker exec进入容器
```
docker exec -ti "CONTAINER ID"  /bin/sh
```
