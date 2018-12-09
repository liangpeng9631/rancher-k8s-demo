rem tag信息
:restart
cls
set /p tag=please input git [tag] info:

rem 环境信息
cls
echo "1.context->dev[default]"
echo "2.context->test"
echo "3.context->release"

set /p context=please input [context] number:


rem CPU信息
cls
echo "1.CPU->100m[default]"
echo "2.CPU->200m"
echo "3.CPU->500m"
echo "4.CPU->1024m"

set /p cpu=please input [cpu] number:

rem 内存信息
cls
echo "1.MEMORY->128Mi[default]"
echo "2.MEMORY->256Mi"
echo "3.MEMORY->512Mi"
echo "4.MEMORY->1024Mi"

set /p memory=please input [memory] number:


rem 是否执行编译
cls
echo "1.ignore"
echo "2.git clone build project"

set /p build=please input [build] number:

rem 是否执行更新
cls
echo "1.ignore"
echo "2.update k8s pods_services"

set /p update=please input [update] number:

rem 编译
if "%build%"=="" (
set build=n
)

if "%build%"=="1" (
set build=n
)

if "%build%"=="2" (
set build=y
)


rem 更新
if "%update%"=="" (
set update=n
)

if "%update%"=="1" (
set update=n
)

if "%update%"=="2" (
set update=y
)

rem 环境参数

if "%context%"=="" (
set context=dev
)

if "%context%"=="1" (
set context=dev
)

if "%context%"=="2" (
set context=test
)

if "%context%"=="3" (
set context=release
)

rem CPU参数

if "%cpu%"=="" (
set cpu=100m
)

if "%cpu%"=="1" (
set cpu=100m
)

if "%cpu%"=="2" (
set cpu=200m
)

if "%cpu%"=="3" (
set cpu=500m
)

if "%cpu%"=="4" (
set cpu=1024m
)

rem MEMORY参数

if "%memory%"=="" (
set memory=128Mi
)

if "%memory%"=="1" (
set memory=128Mi
)

if "%memory%"=="2" (
set memory=256Mi
)

if "%memory%"=="3" (
set memory=512Mi
)

if "%memory%"=="4" (
set memory=1024Mi
)

rem 打印信息确认
cls
echo --------------------
echo tag:%tag%
echo context:%context%
echo cpu:%cpu%
echo memory:%memory%
echo autoBuild:%build%
echo autoUpdate:%update%
echo --------------------
echo\
echo 1.no I want to reset it
echo 2.yes Keep run
echo\
set /p confirm=please input [confirm] number:

if "%confirm%"=="" (
set confirm=1
)

if "%confirm%"=="1" (
goto restart
)

rem 参数判定
if "%tag%"=="" (
echo [tag not input]

pause>nul

goto restart
)