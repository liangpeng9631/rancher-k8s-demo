rem 服务

setlocal ENABLEDELAYEDEXPANSION

set fileService=%dir%..\..\yml\service_%context%.yml 
set tmpServiceFile=%dir%..\..\yml_k8s\%context%\%k8sNamespace%_%k8sName%_service.yml

if exist %tmpServiceFile% (
del %tmpServiceFile%
)

for /f "delims=" %%l in (%fileService%) do (
set str=%%l

set "str=!str:{project}=%k8sName%!"
set "str=!str:{namespace}=%k8sNamespace%!"
set "str=!str:{version}=%tag%!"
set "str=!str:{portip}=%k8sPortIp%!"
set "str=!str:{port}=%projectPort%!"

echo !str!>>%tmpServiceFile%
)

SETLOCAL DISABLEDELAYEDEXPANSION