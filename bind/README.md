## 基于Alpine系统的bind镜像

### 概述
使用Dockerfile构建基于Alpine系统的bind镜像,并采用supervise守护进程。

### 使用说明
```

docker run --name=dns-test  -it -d --dns=8.8.8.8 --dns=8.8.4.4 -p 53:53/udp -p 53:53 aqzt/docker-alpine:bind
或者采用host方式
docker run --name=dns-test  -it -d --dns=8.8.8.8 --dns=8.8.4.4 --net=host aqzt/docker-alpine:bind


```

使用docker exec进入容器
```
docker exec -ti "CONTAINER ID"  /bin/sh
```