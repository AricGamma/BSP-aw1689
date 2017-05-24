
Set SIGN_OEM=1
Set SIGN_WITH_TIMESTAMP=0

set PackDeviceDefaultDir=%WorkRoot%\loong\chips\%Chipset%\devices\default
set BootloaderPreBuiltBinaryDir=%WorkRoot%\loong\prebuilt\%Chipset%\devices\%DeviceName%\bin
cd "%BootloaderPreBuiltBinaryDir%"

set CabVariables=Chipset=%Chipset%;partitionName=boot0;FileName=boot0_sdcard.fex;
call "%WDKCONTENTROOT%\Tools\bin\i386\pkggen.exe" "%PackDeviceDefaultDir%\BinaryPartitionFile.pkg.xml" /build:fre /cpu:%CpuPlatform% /config:"%WDKCONTENTROOT%\Tools\bin\i386\pkggen.cfg.xml" /output:"%DevicePrebuiltCabPath%" /version:0.0.0.1 /variables:"%CabVariables%" +diagnostic

set CabVariables=Chipset=%Chipset%;partitionName=uefi;FileName=boot_package.fex;
call "%WDKCONTENTROOT%\Tools\bin\i386\pkggen.exe" "%PackDeviceDefaultDir%\BinaryPartitionFile.pkg.xml" /build:fre /cpu:%CpuPlatform% /config:"%WDKCONTENTROOT%\Tools\bin\i386\pkggen.cfg.xml" /output:"%DevicePrebuiltCabPath%" /version:0.0.0.1 /variables:"%CabVariables%" +diagnostic

REM set CabVariables=Chipset=%Chipset%;partitionName=acpi;FileName=acpi.fex;
REM call "%WDKCONTENTROOT%\Tools\bin\i386\pkggen.exe" "%PackDeviceDefaultDir%\BinaryPartitionFile.pkg.xml" /build:fre /cpu:%CpuPlatform% /config:"%WDKCONTENTROOT%\Tools\bin\i386\pkggen.cfg.xml" /output:"%DevicePrebuiltCabPath%" /version:0.0.0.1 /variables:"%CabVariables%" +diagnostic

set CabVariables=""

del /s /f /q %DevicePrebuiltCabPath%\*.spkg