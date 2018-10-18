set file=%dir%..\yml\namespace_projectname.yml 
set tmpFile=%dir%..\yml_k8s\%context%\%k8sNamespace%_%k8sName%.yml

if exist %tmpFile% (
del %tmpFile%
)

for /f "delims=" %%l in (%file%) do (
set str=%%l

set "str=!str:{project}=%k8sName%!"
set "str=!str:{namespace}=%k8sNamespace%!"
set "str=!str:{version}=%version%!"
set "str=!str:{tagName}=server.node!"
set "str=!str:{tagVal}=%node%!"
set "str=!str:{img}=%imagesRegistryIp%:%imagesRegistryPort%/%name%:%version%!"

echo !str!>>%tmpFile%
)