@echo off
title %~n0
::判断是否获得管理员权限
fsutil dirty query %SystemDrive% >nul 2>&1 && goto GotPrivileges
::处理参数
set params=%*
if defined params set params=%params:"=""%
::获取管理员权限
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c cd /d ""%~dp0"" && ""%~0"" %params%","%~dp0","runas",1)(close)
exit /b
:GotPrivileges
::
::在安装了VMware Tools的虚拟机内压缩虚拟机磁盘
::
set vmcmd=%ProgramFiles%\VMware\VMware Tools\VMwareToolboxCmd.exe
if exist "%vmcmd%" for /f %%i in ('"%vmcmd%" disk list') do (
	echo 目标位置：%%i
	"%vmcmd%" disk shrink %%i
) else (
	echo 未安装VMware Tools，按任意键退出。。。
	pause > nul
)
:Exit
exit /b
