rem 切换盘符
%~d0

rem 获取当前脚本路径
set dir=%~dp0

rem --------------------------------------------------
rem JDK
set java_bin=%dir%..\..\Java\jdk1.8.0_66\

rem 设置java环境变量
set path=%java_bin%bin;.;%java_bin%lib\dt.jar;%java_bin%lib\tools.jar;%path%
rem --------------------------------------------------

rem 引入通用服务配置
cd %dir%
call [000]default_server_%context%.bat

rem 进入对应环境目录[内网|集成|正式]
cd %dir%..\project\%context%

rem 判定项目文件夹是否存在
if exist .\%name% (
rem 删除已经存在的目录
rd /S/Q .\%name%
)

rem 拉取代码
if %build%==y (
rem cls
call git clone -b %tag% %url% %name%

rem 记录tag说明信息
cd %name%
call git tag %tag% -l -n >> ..\..\..\logs\%context%\%projectPort%_%k8sName%.log
)

rem 执行ant脚本 pjname 名称 pjcontext 环境 pjip 服务器IP pjport 端口 pjuser 用户 pjpassword 密码 pjrunport 容器端口
cd %dir%bin\standard
if %build%==y (
rem cls
call ..\..\..\apache-ant-1.10.1\bin\ant -file .\standard_"%type%".xml -Dpjname="%name%" -Dpjcontext="%context%" -Dpjip="%imagesBuildServerIp%" -Dpjport="%imagesBuildServerPort%" -Dpjuser="%imagesBuildServerUser%" -Dpjpassword="%imagesBuildServerPwd%" -Dpjrunport="%projectPort%" -Dptag="%tag%" -Dprip="%imagesRegistryIp%" -Dprport="%imagesRegistryPort%"
)

rem 生成pods.yml与service.myml
cd %dir%
call [000]default_pods.bat
call [000]default_pods_service.bat

rem 更新部署
if %update%==2 (
call [000]default_deployment_update.bat
)

rem 重新部署
if %update%==3 (
call [000]default_deployment_push.bat
)

rem 输出选项
rem cls
echo -------------------
echo tag:%tag%
echo context:%context%
echo cpu:%cpu%
echo memory:%memory%
echo build:%build%
echo update:%update%
echo port:%projectPort%
echo node:%node%
echo namespace:%k8sNamespace%
echo appname:%k8sName%
echo images:%imagesRegistryIp%:%imagesRegistryPort%/%name%:%tag%
echo --------------------

rem 记录tag消息
cd %dir%..\
echo %imagesRegistryIp%:%imagesRegistryPort%/%k8sName%:%tag% >> logs\%context%\%projectPort%_%k8sName%.log
echo -------------------------------------------------- >>  logs\%context%\%projectPort%_%k8sName%.log
echo\ >> logs\%context%\%projectPort%_%k8sName%.log
echo\ >> logs\%context%\%projectPort%_%k8sName%.log