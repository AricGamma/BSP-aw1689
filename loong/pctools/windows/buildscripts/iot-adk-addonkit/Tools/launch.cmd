@echo off

REM Set IOTADK_ROOT 
set IOTADK_ROOT=%~dp0
REM Getting rid of the \Tools\ at the end
set IOTADK_ROOT=%IOTADK_ROOT:~0,-7%

REM Get the Kits Root path from registry
for /F "skip=2 tokens=2,*" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows Kits\Installed Roots" /v KitsRoot10') do (
	set KITPATH=%%BAssessment and Deployment Kit\Deployment Tools
)
REM Check for ADK Presence and Launch
if exist "%KITPATH%\DandISetEnv.bat" (
	call "%KITPATH%\DandISetEnv.bat"
) else (
	echo.
	echo.Error : ADK not found. Please install ADK.
	echo.
	pause
	exit /b
)
REM Remove temporary variables
set KITPATH= 

REM Check for WDK Presence
if exist "%KITSROOT%\CoreSystem" (
	dir /B /AD "%KITSROOT%CoreSystem" > %IOTADK_ROOT%\wdkversion.txt
	set /P WDK_VERSION=<%IOTADK_ROOT%\wdkversion.txt
	del %IOTADK_ROOT%\wdkversion.txt
) else (
	set WDK_VERSION=NotFound

)

REM Check for Corekit packages
if exist "%KITSROOT%\MSPackages" (
	REM Get version number of the Corekit packages installed
	reg query "HKEY_CLASSES_ROOT\Installer\Dependencies\Microsoft.Windows.Windows_10_IoT_Core_x86_Packages.x86.10" /v Version > %IOTADK_ROOT%\corekitversion.txt 2>nul
	if errorlevel 1 ( 
		REM MSPackages present without this registry key - Assuming older version of packages.
		set COREKIT_VER=10586.0
	) else ( 
		for /F "skip=2 tokens=3" %%r in (%IOTADK_ROOT%\corekitversion.txt) do ( set KIT_VERSION=%%r )
	)
	del %IOTADK_ROOT%\corekitversion.txt	
) else (
	set KIT_VERSION=NotFound
	set COREKIT_VER=NotFound
	echo.Warning : Core kit packages not found. Image creation will fail.
)
if defined KIT_VERSION ( 
	for /f "tokens=2,* delims=." %%A in ("%KIT_VERSION%") do ( set COREKIT_VER=%%B ) 
)

set PATH=%PATH%;%IOTADK_ROOT%\Tools;
TITLE IoTCoreShell
REM Change to Working directory
cd /D %IOTADK_ROOT%\Tools
set OEM_NAME=Allwinner

echo IOTADK_ROOT : %IOTADK_ROOT%
echo WDK_VERSION : %WDK_VERSION%
echo COREKIT_VER : %COREKIT_VER%
echo OEM_NAME    : %OEM_NAME%
echo.
echo Set Environment for Architecture %1
call setenv %1