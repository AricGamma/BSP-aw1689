REM @ECHO OFF
if "%WDKCONTENTROOT%" == "" (
	echo .
	echo .
	echo Please SetBuildEnv before package ffu!
	pause
)

setlocal enabledelayedexpansion
set ImageToolsPath=%WDKCONTENTROOT%\Tools\bin\i386\
set SIGN_OEM=1
set SIGN_WITH_TIMESTAMP=0

if exist %cd%\temp (
	rd /s /q %cd%\temp
)
mkdir %cd%\temp
:usbcheck
for %%i in (c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z) do (
fsutil fsinfo drivetype %%i:>>"%cd%\temp\DRIVER.LOG"
)
findstr /i "Removable" "%cd%\temp\DRIVER.LOG"
if %errorlevel% EQU 0 (
echo There is Removable Drive!!!
echo Please unplug the USB storage device!!!
echo.
pause
del "%cd%\temp\DRIVER.LOG" /f /q>nul 2>nul
goto :usbcheck
)
echo delte the dir....
rd /s /q %cd%\temp\ 

set FfuFileName=%WorkRoot%\loong\ffu\%Chipset%_%DeviceName%_%OemInputTargets%.ffu
set OemInputFile=%WorkRoot%\loong\chips\%Chipset%\devices\%DeviceName%\OemInput_%OemInputTargets%.xml
"%ImageToolsPath%\imggen" %FfuFileName% "%OemInputFile%" "%AKROOT%\MSPackages"  %CpuPlatform%

exit
