@echo off

set Chipset=aw1689
set DeviceName=PINE64
set CpuPlatform=arm
set OemInputTargets=TestOS
set DriverBuildType=Release

set WorkRoot=%cd%

set KITSROOT=C:\Program Files (x86)\Windows Kits\10\
set VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\

set WDKCONTENTROOT=%KITSROOT%
set WPDKCONTENTROOT=%KITSROOT%
set AKROOT=%KITSROOT%
set BUILD_SCRIPTS_ROOT=%workroot%\loong\pctools\windows\buildscripts
set SocPrebuiltCabPath=%workroot%\loong\prebuilt\%Chipset%\CabPackages
set DevicePrebuiltCabPath=%workroot%\loong\prebuilt\%Chipset%\devices\%DeviceName%\CabPackages
set IotAddOnPath=%BUILD_SCRIPTS_ROOT%\iot-adk-addonkit
set PKGBLD_DIR=%IotAddOnPath%\Build\%CpuPlatform%\pkgs

set PATH=%KITSROOT%tools\bin\i386;%PATH%
set PATH=%PATH%;%KITSROOT%\tools\bin\i386;
set PATH=%PATH%;%KITSROOT%\bin\x64;
set PATH=%PATH%;C:\Program Files (x86)\MSBuild\14.0\Bin;
set PATH=%PATH%;C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\BIN;


