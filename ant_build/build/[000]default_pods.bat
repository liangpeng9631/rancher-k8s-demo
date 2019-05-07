rem 模板支持根据环境设置节点与探针等信息

setlocal ENABLEDELAYEDEXPANSION

set file=%dir%..\yml\pods_%type%_%context%.yml 
set tmpFile=%dir%..\yml_k8s\%context%\%k8sNamespace%_%k8sName%.yml

rem 镜像地址生成规则
if %imagesRegistryPort% == 0 (
  set podsImage=%imagesRegistryIp%/%name%:%tag%
) else (
  set podsImage=%imagesRegistryIp%:%imagesRegistryPort%/%name%:%tag%
)

if exist %tmpFile% (
del %tmpFile%
)

for /f "delims=" %%l in (%file%) do (
set str=%%l

set "str=!str:{project}=%k8sName%!"
set "str=!str:{namespace}=%k8sNamespace%!"
set "str=!str:{version}=%tag%!"
set "str=!str:{tagName}=51ykb.com!"
set "str=!str:{node}=%node%!"
set "str=!str:{img}=%podsImage%!"
set "str=!str:{cpu}=%cpu%!"
set "str=!str:{memory}=%memory%!"
set "str=!str:{heap}=%heap%!"
set "str=!str:{k8sWorkingCheck}=%k8sWorkingCheck%!"
set "str=!str:{registryKey}=%registryKey%!"

echo !str!>>%tmpFile%
)

SETLOCAL DISABLEDELAYEDEXPANSION