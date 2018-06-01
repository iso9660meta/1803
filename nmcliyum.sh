#!/bin/bash
nmcli connection add type ethernet con-name $1 ifname $1
nmcli connection modify "$1" ipv4.method manual ipv4.addresses "$2" connection.autoconnect yes
nmcli connection up "$1"
hostnamectl set-hostname "$3"
echo "$*"
ifconfig $1 | awk '/netmask/{print}'
rm  -rf /etc/yum.repos.d/*.repo &> /dev/null
yum=/etc/yum.repos.d/rhel7.repo &> /dev/null

touch $yum
echo "[rhel7]" > $yum
echo "name=rhel7" >> $yum
echo "baseurl=http://192.168.4.254/rhel7" >> $yum
echo "gpgcheck=0" >> $yum
echo "enabled=1" >> $yum
yum clean all &> /dev/null
yum repolist | awk -F: '/repolist/{print}'
