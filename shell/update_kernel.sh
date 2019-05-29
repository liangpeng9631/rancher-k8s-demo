#!/bin/bash

###################
####禁用SElinux########################################################################################################
###################

#临时关闭SElinux
setenforce 0

#永久禁用SElinux,替换/etc/selinux/config下SELINUX的值为disable,-r支持正则表达式,-i修改后备份
sed -ri '/^[^#]*SELINUX=/s#=.+$#=disabled#' /etc/selinux/config

######################
####升级内核至4.20############################################################################################################
######################

#安装wget用于下载远端安装包
yum -y install wget

#安装linux-firmware,升级内核所需的依赖
yum install -y linux-firmware

#创建/data/目录
mkdir -p /data/

#进入所创建的目录
cd /data/;

#下载安装包
wget http://docker-snake.cn-bj.ufileos.com/kernel-ml-4.20.13-1.el7.elrepo.x86_64.rpm
wget http://docker-snake.cn-bj.ufileos.com/kernel-ml-devel-4.20.13-1.el7.elrepo.x86_64.rpm

#通过安装更新内核
rpm -ivh kernel-ml-devel-4.20.13-1.el7.elrepo.x86_64.rpm
rpm -ivh kernel-ml-4.20.13-1.el7.elrepo.x86_64.rpm

#修改内核启动顺序,默认启动的顺序应该为1,升级以后内核是往前面插入,为0（如果每次启动时需要手动选择哪个内核,该步骤可以省略）
grub2-set-default  0 && grub2-mkconfig -o /etc/grub2.cfg

#使用下面命令看看确认下是否启动默认内核指向上面安装的内核
grubby --default-kernel

#
echo please reboot

######################
####升级完内核需要重新挂载服务器磁盘 mount /dev/vdb /data/
######################