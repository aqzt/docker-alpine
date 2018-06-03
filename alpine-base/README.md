## docker-alpine

基于alpine系统构建docker镜像，实现可配置和易于管理的docker镜像。

## 目标

这个项目有以下目标：

- 制作非常小的docker镜像。
- 提供易于配置的docker镜像。
- 提供非常稳定的docker镜像。
- 使用docker镜像快速启用微服务架构。
- 使用docker镜像快速部署监控。

## 快速开始

利用此镜像作为进一步构建的基础。默认情况下，它不会启动s6-overlay系统，请访问[s6 overlay repository](https://github.com/just-containers/s6-overlay) 
关于如何启用S6 init系统时使用此基础或查看我的一些其他镜像的说明。

### 使用说明

快速使用，请访问[https://bbs.aqzt.com/forum-41-1.html](https://bbs.aqzt.com/forum-41-1.html) 


## 配置

### 数据卷

下面的目录用于配置，并且可以映射为持久存储。

| 目录                                | 描述                        |
|-------------------------------------|-----------------------------|
| `/etc/zabbix/zabbix_agentd.conf.d/` | Zabbix Agent 配置目录 |
| `/assets/cron-custom`               | 在这里删除自定义CRONTABS |


### 环境变量

下面是可用于自定义安装的可用选项的完整列表。

| 参数              | 描述                                                   |
|-------------------|----------------------------------------------------------------|
| `DEBUG_MODE`      | Enable Debug Mode - Default: `FALSE`                            |
| `DEBUG_SMTP`      | Setup Mail Catch all on port 1025 (SMTP) and 8025 (HTTP) - Default: `FALSE` |
| `ENABLE_CRON`     | Enable Cron - Default: `TRUE`                                   |
| `ENABLE_SMTP`     | Enable SMTP services - Default: `TRUE`						|
| `ENABLE_ZABBIX`   | Enable Zabbix Agent - Default: `TRUE`                           |
| `TIMEZONE`        | Set Timezone - Default: `Asia/Shanghai`                     |

如果希望发送此邮件，请设置`ENABLE_SMTP=TRUE`，并配置以下环境变量。有关配置MSMTP的选项的进一步信息，请参见[MSMTP Configuration Options](http://msmtp.sourceforge.net/doc/msmtp.html) 

| 参数              | 描述                                                    |
|-------------------|----------------------------------------------------------------|
| `SMTP_HOST`      | Hostname of SMTP Server - Default: `postfix-relay`                            |
| `SMTP_PORT`      | Port of SMTP Server - Default: `25`                            |
| `SMTP_DOMAIN`     | HELO Domain - Default: `docker`                                   |
| `SMTP_MAILDOMAIN`     | Mail Domain From - Default: `example.org`						|
| `SMTP_AUTHENTICATION`     | SMTP Authentication - Default: `none`                                   |
| `SMTP_USER`     | Enable SMTP services - Default: `user`						|
| `SMTP_PASS`   | Enable Zabbix Agent - Default: `password`                           |
| `SMTP_TLS`        | Use TLS - Default: `off`                     |
| `SMTP_STARTTLS`   | Start TLS from within Dession - Default: `off` |
| `SMTP_TLSCERTCHECK` | Check remote certificate - Default: `off` |

有关下列ZabBIX值的信息，请参见[Zabbix Agent文档](https://www.zabbix.com/documentation/2.2/manual/appendix/config/zabbix_agentd)

| Zabbix 参数       | 描述                                                  |
|-------------------|----------------------------------------------------------------|
| `ZABBIX_LOGFILE` | Logfile Location - Default: `/var/log/zabbix/zabbix_agentd.log` |
| `ZABBIX_LOGFILESIZE` | Logfile Size - Default: `1` |
| `ZABBIX_DEBUGLEVEL` | Debug Level - Default: `1` |
| `ZABBIX_REMOTECOMMANDS` | Enable Remote Commands (0/1) - Default: `1` |
| `ZABBIX_REMOTECOMMANDS_LOG` | Enable Remote Commands Log (0/1)| - Default: `1` |
| `ZABBIX_SERVER` | Allow connections from Zabbix Server IP - Default: `0.0.0.0/0` |
| `ZABBIX_LISTEN_PORT` | Zabbix Agent Listening Port - Default: `10050` |
| `ZABBIX_LISTEN_IP` | Zabbix Agent Listening IP - Default: `0.0.0.0` |
| `ZABBIX_START_AGENTS` | How many Zabbix Agents to Start - Default: `0 | 
| `ZABBIX_SERVER_ACTIVE` | Server for Active Checks - Default: `zabbix-proxy` |
| `ZABBIX_HOSTNAME` | Container hostname to report to server - Default: `docker` |
| `ZABBIX_REFRESH_ACTIVE_CHECKS` | Seconds to refresh Active Checks - Default: `120` |
| `ZABBIX_BUFFER_SEND` | Buffer Send - Default: `5` |
| `ZABBIX_BUFFER_SIZE` | Buffer Size - Default: `100` |
| `ZABBIX_MAXLINES_SECOND` | Max Lines Per Second - Default: `20` |
| `ZABBIX_ALLOW_ROOT` | Allow running as root - Default: `1` |
| `ZABBIX_USER` | Zabbix user to start as - Default: `zabbix` |


如果启用`DEBUG_PERMISSIONS=TRUE`，所有用户和组都已根据环境变量进行修改，将在输出中显示。
例如，如果添加`USER_NGINX=1000`，它会将容器“nginx”用户ID从“82”重置为“1000”-提示，也将组ID更改为本地开发用户UID和GID。
避免开发时的用户许可问题。


| 参数     | 描述 |
|-----------|-------------|
| `USER_<USERNAME>` |  The user's UID in /etc/passwd will be modified with new UID - Default `N/A` |
| `GROUP_<GROUPNAME>` | The group's GID in /etc/group and /etc/passwd will be modified with new GID - Default `N/A` |
| `GROUP_ADD_<USERNAME>` | The username will be added in /etc/group after the group name defined - Default `N/A` | 


### 网络


开放的端口

| 端口      | 描述  |
|-----------|--------------|
| `1025`    | `DEBUG_MODE` & `DEBUG_SMTP` SMTP Catcher |
| `8025`    | `DEBUG_MODE` & `DEBUG_SMTP` SMTP HTTP Viewer |
| `10050`   | Zabbix Agent |



## 调试模式


当使用此作为基础镜像时，在启动脚本中创建语句，检查是否存在`DEBUG_MODE=TRUE`，并在应用程序中设置各种参数，以输出更多细节、启用调试模式等。在这个基本镜像中，它做如下操作：

* 设置ZabBIX代理以输出冗长的日志
* 启用MelHog邮件收集器，它用自己的CaskAdl执行替换`/usr/sbin/sendmail` 。它还为SMTP捕获打开端口“1025”，您可以查看它在端口“8025”处捕获的消息。


## 维护
#### 通过shell进入容器

出于调试和维护的目的，您可以访问容器。 

```bash
docker exec -it 你的容器名称 bash
```


## 工具

* https://www.alpinelinux.org