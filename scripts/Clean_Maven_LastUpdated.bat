@echo off
title %~n0
::
::����Maven���������������jar��ʧ���ڱ��زֿ������ɵ�lastUpdated�ļ��������lastUpdated�ļ����µ�jar��ʼ���޷����ص�����
::
set count=0
set list=
call :Del "%USERPROFILE%\.m2\repository"
call :Find "%USERPROFILE%\.m2\settings.xml"
call :Find "%MAVEN_HOME%\conf\settings.xml"
call :Find "%M2_HOME%\conf\settings.xml"
call :Path
if %count% gtr 0 goto Exit
:Re
cls
echo û���ҵ����زֿ⣬����Maven�����������ò��鿴���زֿ��Ƿ�IDE�ض���
set repository=
set /p repository=�����뱾�زֿ�·����
if defined repository set repository=%repository:"=%
echo %repository% | findstr /i "^[A-Z]:[/\\][^:*?<>|]*$" >nul 2>&1 || (
	echo ����·�����Ϸ�����������������롣����
	pause > nul
	goto Re
)
if not exist "%repository%" (
	echo ����·�������ڣ���������������롣����
	pause > nul
	goto Re
)
cls
call :Del "%repository%"
goto Exit
:Del
if ""=="%~1" exit /b
echo "%list%" | find "%~1;" >nul 2>&1 && exit /b
if exist "%~1" (
	echo Ŀ��λ�ã�%~1
	del /f /s /q "%~1\*lastUpdated*"
	set /a count+=1
)
set list=%~1;%list%
exit /b
:Find
if exist "%~1" for /f %%i in ('findstr /i "<localRepository>[A-Z]:[/\\][^:*?<>|]*</localRepository>" "%~1"') do call :_Find "%%~i"
exit /b
:_Find
set "repository=%~1"
set "repository=%repository:<localRepository>=%"
set "repository=%repository:\</localRepository>=%"
set "repository=%repository:</localRepository>=%"
call :Del "%repository%"
set repository=
exit /b
:Path
set $Path=%PATH%
:__Path
for /f "delims=; tokens=1*" %%i in ("%$Path%") do call :_Path "%%i" "%%j"
exit /b
:_Path
if exist "%~1" echo %~1| findstr /i ".*maven.*[/\\]bin[/\\]*$" >nul 2>&1 && (
	call :___Path "%~1\.."
	set $Path=
	exit /b
)
set $Path=%~2
goto __Path
:___Path
call :Find "%~f1\conf\settings.xml"
exit /b
:Exit
exit /b
