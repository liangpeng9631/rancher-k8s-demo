setlocal ENABLEDELAYEDEXPANSION

set file=%dir%..\yml\namespace_projectname_%context%.yml 
set tmpFile=%dir%..\yml_k8s\%context%\%k8sNamespace%_%k8sName%.yml

if exist %tmpFile% (
del %tmpFile%
)

for /f "delims=" %%l in (%file%) do (
set str=%%l

set "str=!str:{project}=%k8sName%!"
set "str=!str:{namespace}=%k8sNamespace%!"
set "str=!str:{version}=%tag%!"
set "str=!str:{tagName}=51ykb.com!"
set "str=!str:{tagVal}=%node%!"
set "str=!str:{img}=%imagesRegistryIp%:%imagesRegistryPort%/%name%:%tag%!"
set "str=!str:{cpu}=%cpu%!"
set "str=!str:{memory}=%memory%!"

echo !str!>>%tmpFile%
)

SETLOCAL DISABLEDELAYEDEXPANSION