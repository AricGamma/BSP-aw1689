echo Start to pack device configs...

Set SIGN_OEM=1
Set SIGN_WITH_TIMESTAMP=0


set PackDeviceDir=%WorkRoot%\loong\chips\%Chipset%\devices\%DeviceName%
set PackDeviceDefaultDir=%PackDeviceDir%\..\default

cd "%PackDeviceDir%"

call "%WDKCONTENTROOT%\Tools\bin\i386\pkggen.exe" "%PackDeviceDefaultDir%\OEMDeviceLayout.pkg.xml" /build:fre /cpu:%CpuPlatform%  /config:"%WDKCONTENTROOT%Tools\bin\i386\pkggen.cfg.xml" /output:"%DevicePrebuiltCabPath%" /version:0.0.0.1 

call "%WDKCONTENTROOT%\Tools\bin\i386\pkggen.exe" "%PackDeviceDefaultDir%\OEMDevicePlatform.pkg.xml" /build:fre /cpu:%CpuPlatform% /config:"%WDKCONTENTROOT%Tools\bin\i386\pkggen.cfg.xml" /output:"%DevicePrebuiltCabPath%" /version:0.0.0.1

call "%WDKCONTENTROOT%\Tools\bin\i386\pkggen.exe" "%PackDeviceDir%\DeviceInfo.pkg.xml" /build:fre /cpu:%CpuPlatform%  /config:"%WDKCONTENTROOT%Tools\bin\i386\pkggen.cfg.xml" /output:"%DevicePrebuiltCabPath%" /version:0.0.0.1

REM call "%WDKCONTENTROOT%\Tools\bin\i386\pkggen.exe" "UpdateOS.pkg.xml" /build:fre /cpu:%CpuPlatform% /config:"%WDKCONTENTROOT%Tools\bin\i386\pkggen.cfg.xml" /output:"." /version:0.0.0.1 

REM cd "%WorkRoot%\SourceCode\Windows\Config\RegistryConfig"
REM call "%WDKCONTENTROOT%\Tools\bin\i386\pkggen.exe" "RegistryConfig.pkg.xml" /build:fre /cpu:%CpuPlatform% /config:"%WDKCONTENTROOT%Tools\bin\i386\pkggen.cfg.xml" /output:"." /version:0.0.0.1 

del /s /f /q %DevicePrebuiltCabPath%\*.spkg