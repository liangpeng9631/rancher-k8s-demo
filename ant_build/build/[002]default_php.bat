@echo off

rem 启用拓展函数
setlocal

rem 设置编码
CHCP 65001

rem 接收外部参数
call [000]default_param.bat

rem ------------------------------ 配置 ------------------------------

rem 项目名称
set name={####}

rem 项目端口
set projectPort={####}

rem 项目类型 php/java
set type={####}

rem 地址
set url={####}

rem yml-k8s项目名称
set k8sName={####}

rem yml-k8s命名空间
set k8sNamespace={####}

rem 节点标签
set node={####}

rem ------------------------------ 配置 ------------------------------

rem 执行编译
call [000]default_exec.bat

rem 等待任意键退出
echo [press any key to exit]

pause>nul

exit