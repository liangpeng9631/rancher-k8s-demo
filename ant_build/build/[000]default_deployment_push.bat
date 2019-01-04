rem 发布应用

rem 删除应用
echo %dir%..\curl\curl
echo -X DELETE
echo -H "Authorization:Bearer %rancherApiKey%"
echo -H "Content-Type: application/yaml"
echo -T "%dir%..\del.yml"
echo %rancherApiUrl%/apis/apps/v1beta1/namespaces/%k8sNamespace%/deployments/%k8sName%
%dir%..\curl\curl -X DELETE -H "Authorization:Bearer %rancherApiKey%" -H "Content-Type: application/yaml" -T "%dir%..\del.yml" %rancherApiUrl%/apis/apps/v1beta1/namespaces/%k8sNamespace%/deployments/%k8sName%
echo ----------------------------------------------------------------------------------------------------

rem 删除服务
echo %dir%..\curl\curl
echo -X DELETE
echo -H "Authorization:Bearer %rancherApiKey%"
echo -H "Content-Type: application/yaml"
echo -T "%dir%..\del.yml"
echo %rancherApiUrl%/api/v1/namespaces/%k8sNamespace%/services/%k8sName%
%dir%..\curl\curl -X DELETE -H "Authorization:Bearer %rancherApiKey%" -H "Content-Type: application/yaml" -T "%dir%..\del.yml" %rancherApiUrl%/api/v1/namespaces/%k8sNamespace%/services/%k8sName%
echo ----------------------------------------------------------------------------------------------------

rem 提交pods部署
echo %dir%..\curl\curl
echo -X POST
echo -H "Authorization:Bearer %rancherApiKey%"
echo -H "Content-Type: application/yaml"
echo -T "%dir%..\yml_k8s\%context%\%k8sNamespace%_%k8sName%.yml"
echo %rancherApiUrl%/apis/extensions/v1beta1/namespaces/%k8sNamespace%/deployments
%dir%..\curl\curl -X POST -H "Authorization:Bearer %rancherApiKey%" ^
-H "Content-Type: application/yaml" ^
-T "%dir%..\yml_k8s\%context%\%k8sNamespace%_%k8sName%.yml" ^
%rancherApiUrl%/apis/extensions/v1beta1/namespaces/%k8sNamespace%/deployments
echo ----------------------------------------------------------------------------------------------------

rem 提交service部署
echo %dir%..\curl\curl
echo -X POST
echo -H "Authorization:Bearer %rancherApiKey%"
echo -H "Content-Type: application/yaml"
echo -T "%dir%..\yml_k8s\%context%\%k8sNamespace%_%k8sName%_service.yml"
echo %rancherApiUrl%/api/v1/namespaces/%k8sNamespace%/services
%dir%..\curl\curl -X POST -H "Authorization:Bearer %rancherApiKey%" ^
-H "Content-Type: application/yaml" ^
-T "%dir%..\yml_k8s\%context%\%k8sNamespace%_%k8sName%_service.yml" ^
%rancherApiUrl%/api/v1/namespaces/%k8sNamespace%/services
echo ----------------------------------------------------------------------------------------------------