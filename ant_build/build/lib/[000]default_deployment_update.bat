rem 更新应用

rem 更新pods更新
echo %dir%..\..\curl\curl
echo -X PATCH
echo -H "Authorization:Bearer %rancherApiKey%"
echo -H "Content-Type: application/strategic-merge-patch+json" 
echo -T "%dir%..\..\yml_k8s\%context%\%k8sNamespace%_%k8sName%.json"
echo %rancherApiUrl%/apis/apps/v1beta1/namespaces/%k8sNamespace%/deployments/%k8sName%

rem 创建提交的json
if %imagesRegistryPort% == 0 (
echo {"spec":{"template":{"spec":{"containers":[{"name":"%k8sName%","image":"%imagesRegistryIp%/%name%:%tag%"}]}}}} > %dir%..\..\yml_k8s\%context%\%k8sNamespace%_%k8sName%.json
) else (
echo {"spec":{"template":{"spec":{"containers":[{"name":"%k8sName%","image":"%imagesRegistryIp%:%imagesRegistryPort%/%name%:%tag%"}]}}}} > %dir%..\..\yml_k8s\%context%\%k8sNamespace%_%k8sName%.json
)

rem 提交更新文件
%dir%..\..\curl\curl -X PATCH -H "Authorization:Bearer %rancherApiKey%" ^
-H "Content-Type: application/strategic-merge-patch+json" ^
-T "%dir%..\..\yml_k8s\%context%\%k8sNamespace%_%k8sName%.json" ^
%rancherApiUrl%/apis/apps/v1beta1/namespaces/%k8sNamespace%/deployments/%k8sName%
echo ----------------------------------------------------------------------------------------------------