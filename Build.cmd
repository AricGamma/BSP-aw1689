@echo off
setlocal enabledelayedexpansion
cd /d %~dp0

REM  --> Check for permissions  
"%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" >nul 2>&1 
  
REM -->we do not have root promission if errorlevel sets
if '%errorlevel%' NEQ '0' (  
    echo Requesting privileges...  
    goto UACReq  
) else ( goto gotUAC )  
  
:UACReq 
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getuac.vbs"  
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getuac.vbs"  
  
    "%temp%\getuac.vbs"  
    exit /B  
  
:gotUAC  
    if exist "%temp%\getuac.vbs" ( del "%temp%\getuac.vbs" )  


call "SetBuildEnv.cmd"

cd "%WorkRoot%"


:Select
cls
cd %WorkRoot%

color 0b
title Build - %Chipset%_%DeviceName%_%OemInputTargets%.ffu

echo windows 10 IOT build system for Allwinner Platform
echo.
echo -----------------------------------------------------------------
echo Build Image Name:%Chipset%_%DeviceName%_%OemInputTargets%.ffu
echo -----------------------------------------------------------------
echo.
echo You have following options:
echo ******************************************
echo *                                        *
echo * 1. Pack  Bootloader(boot0/uefi)        *
echo * 2. Pack  DevcieConfig packages         *
echo * 3. Pack  Boot-resource package         *
echo * 4. Pack  FFU                           *
echo * 5. Quit                                *
echo *                                        *
echo ******************************************

choice /c 123456 /N /M "Please input your choice:"

echo "Your choice is %errorlevel%"
if errorlevel 6 (
   echo "finish the build"
 	goto :Finish
)


if errorlevel 4 (
  echo "pack ffu"
	call "%BUILD_SCRIPTS_ROOT%\PackFfu.cmd"
	pause	
	goto :Select
)


if errorlevel 3 (
  echo "pack boot-resource"
	call "%BUILD_SCRIPTS_ROOT%\PackBootresource.cmd"
	pause	
	goto :Select
)

if errorlevel 2 (
	echo "pack device configs"
	call "%BUILD_SCRIPTS_ROOT%\PackDeviceConfigs.cmd"
	pause	
	goto :Select
)

if errorlevel 1 (
	echo "pack bootloader"	
	call "%BUILD_SCRIPTS_ROOT%\PackBootloader.cmd"
	pause	
	goto :Select
)

:Finish
cd %workroot%
