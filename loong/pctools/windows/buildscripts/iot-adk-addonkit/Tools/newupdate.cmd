:: This script creates the folder structure and copies the template files for a new product
@echo off

goto :START

:Usage
echo Usage: newupdate UpdateName Version
echo    UpdateName....... Required, Name of the Update to be created.
echo    Version.......... Version number (eg. x.y.z.a)
echo    [/?]............. Displays this usage string.
echo    Example:
echo        newupdate Update2 10.0.2.0

echo Existing Updates and versions are
type %SRC_DIR%\Updates\UpdateVersions.txt

exit /b 1

:START
setlocal
if [%1] == [/?] goto Usage
if [%1] == [-?] goto Usage
if [%1] == [] goto Usage
if [%2] == [] goto Usage

if NOT DEFINED SRC_DIR (
    echo Environment not defined. Call setenv
    goto End
)
:: Error Checks

if /i EXIST %SRC_DIR%\Updates\%1 (
    echo Error: %1 already exists
    goto End
)
:: Start processing command
echo Creating %1
SET UPDATE=%1
SET VERSION=%2

mkdir "%SRC_DIR%\Updates\%UPDATE%"
echo %UPDATE% %VERSION% >> %SRC_DIR%\Updates\UpdateVersions.txt
echo %VERSION% > %SRC_DIR%\Updates\%UPDATE%\versioninfo.txt

powershell -Command "(gc %IOTADK_ROOT%\Templates\UpdateInput.xml) -replace 'UpdateName', '%UPDATE%' | Out-File %SRC_DIR%\Updates\%UPDATE%\UpdateInput.xml -Encoding utf8"

echo %1 directories ready
goto End

:Error
endlocal
echo "newupdate %1 " failed with error %ERRORLEVEL%
exit /b 1

:End
endlocal
exit /b 0
