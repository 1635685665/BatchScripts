@echo off
title %~n0
::�ж��Ƿ��ù���ԱȨ��
fsutil dirty query %SystemDrive% >nul 2>&1 && goto GotPrivileges
::�������
set params=%*
if defined params set params=%params:"=""%
::��ȡ����ԱȨ��
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c cd /d ""%~dp0"" && ""%~0"" %params%","%~dp0","runas",1)(close)
exit /b
:GotPrivileges
::
::�ڰ�װ��VMware Tools���������ѹ�����������
::
set vmcmd=%ProgramFiles%\VMware\VMware Tools\VMwareToolboxCmd.exe
if exist "%vmcmd%" for /f %%i in ('"%vmcmd%" disk list') do (
	echo Ŀ��λ�ã�%%i
	"%vmcmd%" disk shrink %%i
) else (
	echo δ��װVMware Tools����������˳�������
	pause > nul
)
:Exit
exit /b
