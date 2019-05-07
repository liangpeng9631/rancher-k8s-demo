##  此脚本用于将应用打包成docker镜像推送至私有的镜像库中
##
##  参数说明
##
##  $1 项目名称
##  $2 镜像库地址
##  $3 镜像库端口
##  $4 项目版本tag

#!/bin/sh

if [ -z "$1" ]
then
    echo "error:please input run name in first param"
    exit
fi

if [ -z "$2" ]
then
    echo "error:please input port in second param"
    exit
fi

#构建容器
cd $(dirname "$0")
docker build --rm -f DockerFile -t $1:$4 .

#推送镜像到镜像库  ip:port/name:tag
echo "docker tag $1 $2/$1:$4"
docker tag $1:$4 $2/$1:$4

#登录私有镜像库
docker login -u yangy@yuanian.com -p redhat021 uhub.service.ucloud.cn

echo "docker push $2/$1:$4"
docker push $2/$1:$4

#删除镜像tag
echo "docker rmi $2/$1:$4"
docker rmi $2/$1:$4

#删除镜像
echo "docker rmi $1:$4"
docker rmi $1:$4