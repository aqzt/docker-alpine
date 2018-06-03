#!/bin/sh
echo "agent-install.sh zabbix-server-IP zabbix-agentd-IP"
if [ "$1" == "" ];then
    echo "example:agent-install.sh zabbix-server-IP zabbix-agentd-IP"
    exit 1
fi
if [ "$2" == "" ];then
    echo "example:agent-install.sh zabbix-server-IP zabbix-agentd-IP"
    exit 1
fi

sleep 3
zabbixdir=`pwd`
zabbix_version=3.4.8
ip=`ip addr |grep inet |egrep -v "inet6|127.0.0.1" |awk '{print $2}' |awk -F "/" '{print $1}'`
echo "当前目录为:$zabbixdir"
echo "本机ip为:$ip"
#cat $zabbixdir/Readme
ServerIP=$1
AgentdIP=$2
echo "zabbix服务器ip为:$ServerIP"
isY="y"
if [ "${isY}" != "y" ] && [ "${isY}" != "Y" ] && [ "${isY}" != "yes" ] && [ "${isY}" != "YES" ];then
exit 1
fi
echo "安装相关组件"
yum install -y ntpdate gcc gcc-c++ wget unixODBC unixODBC-devel
echo "同步服务器时间"
ntpdate asia.pool.ntp.org
echo "创建zabbix用户"
groupadd zabbix
useradd -g zabbix zabbix

echo "安装zabbix-agent"
sleep 3
wget http://netix.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/$zabbix_version/zabbix-${zabbix_version}.tar.gz
#wget http://$ServerIP/zabbix/zabbix-${zabbix_version}.tar.gz
tar zxvf $zabbixdir/zabbix-${zabbix_version}.tar.gz
cd $zabbixdir/zabbix-${zabbix_version}
echo `pwd`
./configure --prefix=/usr/local/zabbix/ --enable-agent
sleep 3
make
make install
echo "配置zabbix server ip为 $ServerIP"
#sed -i "s/Server=127.0.0.1/Server=$ServerIP/g" /usr/local/zabbix/etc/zabbix_agentd.conf
cat >/usr/local/zabbix/etc/zabbix_agentd.conf<<EOF
LogFile=/tmp/zabbix_agentd.log
ServerActive=$ServerIP
StartAgents=0
Hostname=$AgentdIP
RefreshActiveChecks=120
BufferSize=200
Timeout=30
UnsafeUserParameters=1
EOF


echo "创建启动init"
cp $zabbixdir/zabbix-${zabbix_version}/misc/init.d/tru64/zabbix_agentd /etc/init.d/
chmod +x /etc/init.d/zabbix_agentd
sed -i "s:DAEMON=/usr/local/sbin/zabbix_agentd:DAEMON=/usr/local/zabbix/sbin/zabbix_agentd:g" /etc/init.d/zabbix_agentd
echo "启动zabbix_agentd"
/etc/init.d/zabbix_agentd restart
