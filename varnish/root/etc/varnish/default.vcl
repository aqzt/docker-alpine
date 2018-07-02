#  varnishd -f /etc/varnish/default.vcl -s malloc,100M -a 0.0.0.0:80 -a 0.0.0.0:81,PROXY
vcl 4.0;


backend default {
        .host = "172.17.0.4";
        .port = "80";
}

