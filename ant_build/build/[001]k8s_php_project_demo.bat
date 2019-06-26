@echo off

rem 启用拓展函数
setlocal

rem 设置编码
CHCP 65001

rem 接收启动参数
set tag=%1
set context=%2
set cpu=%3
set memory=%4
set build=%5
set update=%6
set confirm=2

rem 获取当前脚本路径
set baseDir=%~dp0

rem 接收外部参数
call %baseDir%\lib\[000]default_param.bat

rem ------------------------------ 配置 ------------------------------

rem 项目名称
set name=k8s_php_project_demo

rem 项目端口
set projectPort=20000

rem 项目类型 crond/fpm/java/lumen/netcore/ngx/php
set type=php_fpm

rem 地址
set url=https://gitee.com/aisao/k8s_php_project_demo.git

rem yml-k8s项目名称
set k8sName=k8s-php-demo

rem yml-k8s命名空间
set k8sNamespace=demo

rem 节点标签
set node=service

rem 存活检测url
set k8sWorkingCheck=/index/index

rem 镜像拉取秘钥
set registryKey=ykb

rem ------------------------------ 配置 ------------------------------

rem 执行编译
call %baseDir%\lib\[000]default_exec.bat

rem 等待任意键退出
echo [press any key to exit]

pause>nul

exit