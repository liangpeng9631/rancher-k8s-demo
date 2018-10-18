@echo off

:启用拓展函数
setlocal enabledelayedexpansion

:设置编码
CHCP 936

:参数判定
if "%1"=="" (
echo [tag not input]

pause>nul

exit
)

:参数判定
if "%2"=="" (
echo [context not input dev/test/release]

pause>nul

exit
)

:------------------------------ 配置 ------------------------------

:项目名称
set name=k8s_dnet_demo

:项目端口
set projectPort=20002

:项目类型 php/java/netcore
set type=netcore

:地址
set url=https://gitee.com/aisao/k8s_dnet_project_demo.git

:yml-k8s项目名称
set k8sName=k8s-dnet-demo

:yml-k8s命名空间
set k8sNamespace=demo

:节点标签
set node=service

:------------------------------ 配置 ------------------------------

:环境 dev/test/release
set context=%2

:切换盘符
%~d0

:获取当前脚本路径
set dir=%~dp0

:引入通用服务配置
cd %dir%
call [000]default_server_%context%.bat

:进入对应环境目录[内网|集成|正式]
cd %dir%..\project\%context%

:判定项目文件夹是否存在
if exist .\%name% (
:删除已经存在的目录
rd /S/Q .\%name%
)

:设置发布目录
set publishadr=%dir%..\project\%context%\%name%\publish

:拉取代码
call git clone -b %1 %url% %name%

:进入项目文件夹
cd %name%\%name%

call dotnet publish --output %publishadr%

:执行ant脚本 pjname 名称 pjcontext 环境 pjip 服务器IP pjport 端口 pjuser 用户 pjpassword 密码 pjrunport 容器端口
cd %dir%bin\standard
call ..\..\..\apache-ant-1.10.1\bin\ant -file .\standard_"%type%".xml -Dpjname="%name%" -Dpjcontext="%context%" -Dpjip="%imagesBuildServerIp%" -Dpjport="%imagesBuildServerPort%" -Dpjuser="%imagesBuildServerUser%" -Dpjpassword="%imagesBuildServerPwd%" -Dpjrunport="%projectPort%" -Dptag="%1" -Dprip="%imagesRegistryIp%" -Dprport="%imagesRegistryPort%"

:生成pods.yml与service.myml
cd %dir%
call [000]default_pods.bat
call [000]default_pods_service.bat

:等待任意键退出
echo [press any key to exit]

pause>nul

exit