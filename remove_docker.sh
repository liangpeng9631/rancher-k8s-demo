#关闭docker
service docker stop

####卸载docker与k8s
yum -y remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

#查看rmp安装的docker
rpm -qa | grep docker

#rmp方式卸载
rpm -e --nodeps docker-engine-selinux-17.05.0.ce-1.el7.centos.noarch
rpm -e --nodeps docker-engine-1.12.6-1.el7.centos.x86_64

#清理docker目录
rm -rf /data/docker
rm -rf /var/lib/docker

#清理k8s目录
rm -rf /var/lib/kubelet

rm -rf /var/etcd/backups

#清理rancher目录
rm -rf /var/lib/rancher

#删除docker0虚拟网卡

#安装brctl
yum -y install bridge-utils net-tools

#关闭网卡
ifconfig docker0 down

#删除网卡
brctl delbr docker0
