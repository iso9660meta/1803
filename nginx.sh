#!/bin/bash
yum -y install gcc pcre-devel openssl-devel
useradd -s /sbin/nologin nginx
[ -z nginx-1.12.2 ] && rm -rf nginx-1.12.2
tar -xf nginx-1.12.2.tar.gz
cd nginx-1.12.2
./configure  --prefix=/usr/local/nginx  --user=nginx  --group=nginx  --with-http_ssl_module
make && make install
/usr/local/nginx/sbin/nginx
ln -s /usr/local/nginx/sbin/nginx  /sbin
nginx -V
netstat  -anptu  |  grep nginx
firewall-cmd --set-default-zone=trusted
setenforce 0
firefox http://192.168.4.5
sed -i '37i auth_basic "Input Password:";'  /usr/local/nginx/conf/nginx.conf
sed -i '38i auth_basic_user_file "/usr/local/nginx/pass";'  /usr/local/nginx/conf/nginx.conf
yum -y install  httpd-tools
htpasswd -c /usr/local/nginx/pass   tom 
