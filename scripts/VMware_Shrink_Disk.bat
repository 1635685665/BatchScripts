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
cd /d "%ProgramFiles%\VMware\VMware Tools"
for /f %%i in ('VMwareToolboxCmd disk list') do (
	echo Ŀ��λ�ã�%%i
	VMwareToolboxCmd disk shrink %%i
)
:Exit
exit /b
