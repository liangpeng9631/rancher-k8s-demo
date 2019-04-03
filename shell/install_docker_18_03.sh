#!/bin/bash

#简述,脚本对应centos7.x 最小化安装版本,安装docker的目录为系统默认,采用ln方式映射至/data/docker下
#推荐主机名改为与内网一致的IP,'.'由'-'替换,入 192.168.0.10 -> 192-168-0-10,rancher1.6.x识别.的主机名有些问题

#查看内核版本 
#grubby --default-kernel

###################
####禁用SElinux########################################################################################################
###################

#临时关闭SElinux
setenforce 0

#永久禁用SElinux,替换/etc/selinux/config下SELINUX的值为disable,-r支持正则表达式,-i修改后备份
sed -ri '/^[^#]*SELINUX=/s#=.+$#=disabled#' /etc/selinux/config

#############################
####关闭centos7默认防火墙########################################################################################################
#############################

#关闭防火墙
systemctl stop firewalld.service

#禁用开机运行
systemctl disable firewalld.service

#查看防火墙状态
firewall-cmd --state

####################
####默认时区设置###############################################################################################
####################

#设置时区为东八时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

####################################
####关闭swap缓冲区适应高版本K8s###################################################################################################
####################################

#关闭缓冲
swapoff -a && sysctl -w vm.swappiness=0

#更新缓冲配置
sed -ri '/^[^#]*swap/s@^@#@' /etc/fstab

####################
####安装系统依赖###############################################################################################
####################

#安装docker所需的依赖
yum -y install policycoreutils-python selinux-policy-base selinux-policy-targeted libseccomp libtool-ltdl device-mapper-libs pigz lvm2 yum-plugin-ovl

########################
####下载并安装docker###############################################################################################
########################

#安装wget用于下载远端安装包
yum -y install wget

#创建/data/目录
mkdir -p /data/

#进入所创建的目录
cd /data/;

#创建docker目录
mkdir -p docker;

#将docker默认安装目录映射至
ln -s /data/docker /var/lib/docker;

#下载远端安包
wget http://docker-snake.cn-bj.ufileos.com/container-selinux-2.74-1.el7.noarch.rpm
wget http://docker-snake.cn-bj.ufileos.com/docker-ce-18.03.1.ce-1.el7.centos.x86_64.rpm

#通过安装包安装docker
rpm -ivh container-selinux-2.74-1.el7.noarch.rpm
rpm -ivh docker-ce-18.03.1.ce-1.el7.centos.x86_64.rpm

#启动docker
service docker start

#设置docker镜像库源地址与默认日志的大小和文件系统类型
tee /etc/docker/daemon.json <<-'EOF'
{"registry-mirrors":["https://registry.docker-cn.com"],"log-driver":"json-file","log-opts":{"max-size":"5m"},"storage-driver":"overlay2","storage-opts":["overlay2.override_kernel_check=true"]}
EOF

#重新启动docker
service docker restart