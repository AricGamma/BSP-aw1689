:: Run setenv before running this script
:: This script creates the folder structure and copies the template files for a new package
@echo off

goto START

:Usage
echo Usage: appx2pkg input.appx [CompName.SubCompName]
echo    input.appx.............. Required, input .appx file
echo    CompName.SubCompName.... Optional, default is Appx.input
echo    [/?].................... Displays this usage string.
echo    Example:
echo        appx2pkg C:\test\sample_1.0.0.0_arm.appx
exit /b 1

:START

setlocal ENABLEDELAYEDEXPANSION

if [%1] == [/?] goto Usage
if [%1] == [-?] goto Usage
if [%1] == [] goto Usage
if not [%~x1] == [.appx] goto Usage
set LONG_NAME=%~n1
set "FILE_PATH=%~dp1"

for /f "tokens=1,2,3 delims=_" %%i in ("%LONG_NAME%") do (
    set FILE_NAME=%%i
    set FILE_Version=%%j
    set FILE_ARCH=%%k
)

if [%2] == [] (
    set COMP_NAME=Appx
    set SUB_NAME=%FILE_NAME%
) else (
    for /f "tokens=1,2 delims=." %%i in ("%2") do (
        set COMP_NAME=%%i
        set SUB_NAME=%%j
    )
)

REM Start processing command
REM Get Appx dependencies
if exist "%FILE_PATH%\Dependencies\%ARCH%" (
dir /b "%FILE_PATH%\Dependencies\%ARCH%\*.appx" > "%FILE_PATH%\appx_deplist.txt"
) else (
dir /b "%FILE_PATH%\Dependencies\*.appx" > "%FILE_PATH%\appx_deplist.txt"
)
dir /b "%IOTADK_ROOT%\Templates\AppInstall\*.cmd" > "%FILE_PATH%\appx_scriptlist.txt"
dir /b "%FILE_PATH%\*.cer" > "%FILE_PATH%\appx_cerlist.txt"
echo. Authoring %COMP_NAME%.%SUB_NAME%.pkg.xml
if exist "%FILE_PATH%\%COMP_NAME%.%SUB_NAME%.pkg.xml" (del "%FILE_PATH%\%COMP_NAME%.%SUB_NAME%.pkg.xml" )
call :CREATE_PKGFILE


REM Cleanup temp files
REM del "%FILE_PATH%\appx_deplist.txt"
del "%FILE_PATH%\appx_scriptlist.txt"

endlocal
exit /b 0

:CREATE_PKGFILE
if not exist "%FILE_PATH%\appx_deplist.txt" (
    echo. error, file not found :%FILE_PATH%\appx_deplist.txt
    exit /b 1
)
REM Printing the headers
call :PRINT_TEXT "<?xml version="1.0" encoding="utf-8" ?>"
call :PRINT_TEXT "<Package xmlns="urn:Microsoft.WindowsPhone/PackageSchema.v8.00""
echo          Owner="$(OEMNAME)" OwnerType="OEM" ReleaseType="Production" >> "%FILE_PATH%\%COMP_NAME%.%SUB_NAME%.pkg.xml"
call :PRINT_TEXT "         Platform="%BSP_ARCH%" Component="%COMP_NAME%" SubComponent="%SUB_NAME%">"
call :PRINT_TEXT "   <Components>"
call :PRINT_TEXT "      <OSComponent>"
call :PRINT_TEXT "         <Files>"
REM Printing script files inclusion
for /f "useback delims=" %%A in ("%FILE_PATH%\appx_scriptlist.txt") do (
    call :PRINT_TEXT "            <File Source="AppInstall\%%A" "
    echo                   DestinationDir="$(runtime.root)\AppInstall" >> "%FILE_PATH%\%COMP_NAME%.%SUB_NAME%.pkg.xml"
    call :PRINT_TEXT "                  Name="%%A" />"
)
call :PRINT_TEXT "            <File Source="AppInstall\%LONG_NAME%.appx" "
echo                   DestinationDir="$(runtime.root)\AppInstall" >> "%FILE_PATH%\%COMP_NAME%.%SUB_NAME%.pkg.xml"
call :PRINT_TEXT "                  Name="%LONG_NAME%.appx" />"

REM Printing Certificates
for /f "useback delims=" %%A in ("%FILE_PATH%\appx_cerlist.txt") do (
    call :PRINT_TEXT "            <File Source="AppInstall\%%A" "
    echo                   DestinationDir="$(runtime.root)\AppInstall" >> "%FILE_PATH%\%COMP_NAME%.%SUB_NAME%.pkg.xml"
    call :PRINT_TEXT "                  Name="%%A" />"
)
REM Printing Dependencies
for /f "useback delims=" %%A in ("%FILE_PATH%\appx_deplist.txt") do (
    call :PRINT_TEXT "            <File Source="AppInstall\%%A" "
    echo                   DestinationDir="$(runtime.root)\AppInstall" >> "%FILE_PATH%\%COMP_NAME%.%SUB_NAME%.pkg.xml"
    call :PRINT_TEXT "                  Name="%%A" />"
)

call :PRINT_TEXT "         </Files>"
call :PRINT_TEXT "      </OSComponent>"
call :PRINT_TEXT "   </Components>"
call :PRINT_TEXT "</Package>"
)
exit /b 0

:PRINT_TEXT
for /f "useback tokens=*" %%a in ('%1') do set TEXT=%%~a
echo !TEXT! >> "%FILE_PATH%\%COMP_NAME%.%SUB_NAME%.pkg.xml"
exit /b