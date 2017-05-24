
Set SIGN_OEM=1
Set SIGN_WITH_TIMESTAMP=0

set PackDeviceDefaultDir=%WorkRoot%\loong\chips\%Chipset%\devices\default
set BootloaderPreBuiltBinaryDir=%WorkRoot%\loong\prebuilt\%Chipset%\devices\%DeviceName%\bin
set WORKSPACE=%WorkRoot%\loong\chips\%Chipset%\devices\%DeviceName%\acpi
set BLDFLDR=%WORKSPACE%\src
set ACPI_BUILD_OUTPUT=%WORKSPACE%\ACPI
set BIN=%WorkRoot%\loong\pctools\windows\acpi
set SOURCEDIR=%WorkRoot%\loong\chips\%Chipset%\boot-resource\fsbuild
set LOGODIR=%WorkRoot%\loong\chips\%Chipset%\devices\%DeviceName%\logo

IF EXIST !VCINSTALLDIR!bin\x86_ARM\cl.exe (
    set path=!VCINSTALLDIR!bin\x86_ARM;!path! 
) ELSE (
    set path=!VCINSTALLDIR!\bin\x86\arm;!path!
)

if not exist "ACPI_BUILD_OUTPUT" (
    md %ACPI_BUILD_OUTPUT%
)
    

cd "%BLDFLDR%"

for /f %%b in ('dir /b %BLDFLDR%\ArmDsdt.asl') do (
    if not "%%~xb"==".aslc" (
        echo %%b
	"%WDKCONTENTROOT%\Tools\x64\ACPIVerify\asl.exe" /nologo /Fo="%ACPI_BUILD_OUTPUT%\%%~nb.aml" "%BLDFLDR%\%%~nb.asl"
        if NOT ERRORLEVEL 0 GOTO:EOF
	if ERRORLEVEL 1 GOTO:EOF
    )
)

popd >NUL

for /f %%a in ('dir /b %BLDFLDR%\*.aslc') do (
    cl /nologo /Fo%BLDFLDR%\%%~na.obj /WX /c /TC /I%WORKSPACE%\inc %BLDFLDR%\%%~na.aslc
    if NOT ERRORLEVEL 0 GOTO:EOF
    if ERRORLEVEL 1 GOTO:EOF
    link /DLL /MACHINE:ARM /NODEFAULTLIB /NOENTRY /NOLOGO /OUT:%BLDFLDR%\%%~na.dll %BLDFLDR%\%%~na.obj
    if NOT ERRORLEVEL 0 GOTO:EOF
    if ERRORLEVEL 1 GOTO:EOF
    %BIN%\acpi_extract.exe %BLDFLDR%\%%~na.dll %ACPI_BUILD_OUTPUT%\%%~na.acpi
    if NOT ERRORLEVEL 0 GOTO:EOF
    if ERRORLEVEL 1 GOTO:EOF
)
del /s /f /q %BLDFLDR%\*.dll
del /s /f /q %BLDFLDR%\*.obj


if exist "%SOURCEDIR%\boot-resource\ACPI" (
    rd /s /q %SOURCEDIR%\boot-resource\ACPI
)

md %SOURCEDIR%\boot-resource\ACPI
xcopy "%ACPI_BUILD_OUTPUT%" "%SOURCEDIR%\boot-resource\ACPI"

if exist "%SOURCEDIR%\boot-resource\logo" (
    rd  /s /q %SOURCEDIR%\boot-resource\logo
)
md  %SOURCEDIR%\boot-resource\logo
xcopy "%LOGODIR%" "%SOURCEDIR%\boot-resource\logo"

cd "%SOURCEDIR%"
call  "%SOURCEDIR%\test.bat" 

cd "%BootloaderPreBuiltBinaryDir%"
if exist "boot-resource.fex" (
    del /s /q boot-resource.fex
)

xcopy "%SOURCEDIR%\boot-resource.fex" "%BootloaderPreBuiltBinaryDir%"

set CabVariables=Chipset=%Chipset%;partitionName=bootloader;FileName=boot-resource.fex;
call "%WDKCONTENTROOT%\Tools\bin\i386\pkggen.exe" "%PackDeviceDefaultDir%\BinaryPartitionFile.pkg.xml" /build:fre /cpu:%CpuPlatform% /config:"%WDKCONTENTROOT%\Tools\bin\i386\pkggen.cfg.xml" /output:"%DevicePrebuiltCabPath%" /version:0.0.0.1 /variables:"%CabVariables%" +diagnostic

set CabVariables=""

del /s /f /q %DevicePrebuiltCabPath%\*.spkg

goto :EOF

