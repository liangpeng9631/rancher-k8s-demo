rem tag信息
:restart
rem cls
set /p tag=please input git [tag] info:

rem 环境信息
rem cls
echo "1.context->dev[default]"
echo "2.context->test"
echo "3.context->release"
echo "4.context->wuhan"
echo "5.context->dev_demo"
echo "6.context->release_ingress"

set /p context=please input [context] number:


rem CPU信息
rem cls
echo "1.CPU->100m[default]"
echo "2.CPU->200m"
echo "3.CPU->500m"
echo "4.CPU->1024m"
echo "5.CPU->2048m"

set /p cpu=please input [cpu] number:

rem 内存信息 堆栈固定比例100:25 仅JAVA
rem cls
echo "1.MEMORY->128Mi  (heap96Mi   _ stack32Mi)[default]"
echo "2.MEMORY->256Mi  (heap192Mi  _ stack64Mi)"
echo "3.MEMORY->512Mi  (heap384Mi  _ stack128Mi)"
echo "4.MEMORY->768Mi  (heap576Mi  _ stack192Mi)"
echo "5.MEMORY->1024Mi (heap768Mi  _ stack256Mi)"
echo "6.MEMORY->2048Mi (heap1536Mi _ stack512Mi)"

set /p memory=please input [memory] number:


rem 是否执行编译
rem cls
echo "1.ignore"
echo "2.git clone build project"

set /p build=please input [build] number:

rem 是否执行更新
rem cls
echo "1.ignore"
echo "2.update k8s pods_services"
echo "3.deployment k8s pods_services"

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
set update=1
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

if "%context%"=="4" (
set context=wuhan
)

if "%context%"=="5" (
set context=dev_demo
)

if "%context%"=="6" (
set context=release_ingress
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

if "%cpu%"=="5" (
set cpu=2048m
)

rem MEMORY参数

if "%memory%"=="" (
set memory=128Mi
set heap=96m
)

if "%memory%"=="1" (
set memory=128Mi
set heap=96m
)

if "%memory%"=="2" (
set memory=256Mi
set heap=192m
)

if "%memory%"=="3" (
set memory=512Mi
set heap=384m
)

if "%memory%"=="4" (
set memory=768Mi
set heap=576m
)

if "%memory%"=="5" (
set memory=1024Mi
set heap=768m
)

if "%memory%"=="6" (
set memory=2048Mi
set heap=1536m
)

rem 打印信息确认
rem cls
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