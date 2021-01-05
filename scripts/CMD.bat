@echo off
title %~n0
::
::在当前目录打开CMD
::
cd /d "%~dp0"
cmd.exe
:Exit
exit /b
