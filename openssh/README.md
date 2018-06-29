## 基于Alpine系统的OpenSSH镜像

### 概述
使用Dockerfile构建基于Alpine系统的OpenSSH镜像,并采用supervise守护进程。

### 使用说明
```

docker run --rm --publish=8080:22 --env ROOT_PASSWORD=Root123  aqzt/docker-alpine:ssh
docker run -d --name ssh -ti -p 8080:22  -e ROOT_PASSWORD=Root123 aqzt/docker-alpine:ssh
docker run -d --name ssh -it --net=host  -e ROOT_PASSWORD=Root123 aqzt/docker-alpine:ssh

```

使用ssh连接进入容器
```
$ ssh root@127.0.0.1 -p 8080
```