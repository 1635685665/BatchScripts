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
::测试获得管理员权限
::
echo.
echo Got Privileges! :)
echo.
pause
:Exit
exit /b
