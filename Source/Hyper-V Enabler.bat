@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
title Hyper-V Enabler
pushd "%~dp0"
dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hyper-v.config
for /f %%i in ('findstr /i . hyper-v.config 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
del hyper-v.config
Dism /online /enable-feature /featurename:Microsoft-Hyper-V -All /LimitAccess /ALL
timeout 10