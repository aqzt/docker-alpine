## 基于Alpine系统的varnish镜像

### 概述
使用Dockerfile构建基于Alpine系统的varnish镜像,并采用supervise守护进程。

### 使用说明
```
docker run --name=varnish --restart=always  -d -p 80:80 -p 81:81 aqzt/docker-alpine:varnish
docker run --name=varnish --restart=always  -d -p 80:80 -p 81:81 -v /varnish:/etc/varnish aqzt/docker-alpine:varnish
或者采用host方式
docker run --name=varnish --restart=always  -d --net=host -v /varnish:/etc/varnish aqzt/docker-alpine:varnish

```

使用docker exec进入容器
```
docker exec -ti "CONTAINER ID"  /bin/sh
```