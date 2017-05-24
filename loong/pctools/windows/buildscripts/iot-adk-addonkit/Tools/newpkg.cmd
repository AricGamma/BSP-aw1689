:: Run setenv before running this script
:: This script creates the folder structure and copies the template files for a new package
@echo off

goto START

:Usage
echo Usage: newpkg pkgtype comp-name sub-comp-name
echo    pkgtype......... Required, Type of the package created (pkgAppx/pkgDrv/pkgFile)
echo    comp-name....... Required, Component Name for the package
echo    sub-comp-name... Required, Sub-Component Name for the package
echo    [/?].............. Displays this usage string.
echo    Example:
echo        newpkg pkgAppx Appx Blinky
echo        newpkg pkgDrv Drivers SDIO
echo Existing packages are
dir /b /AD %SRC_DIR%\Packages

exit /b 1

:START
setlocal

if [%1] == [/?] goto Usage
if [%1] == [-?] goto Usage
if [%1] == [] goto Usage
if /I NOT [%1] == [pkgAppx] ( if /I NOT [%1] == [pkgDrv] (if /I NOT [%1] == [pkgFile] goto Usage ))
if [%2] == [] goto Usage
if [%3] == [] goto Usage

if NOT DEFINED SRC_DIR (
    echo Environment not defined. Call setenv
    goto End
)
SET NEWPKG_DIR=%SRC_DIR%\Packages\%2.%3

:: Error Checks
if /i EXIST %NEWPKG_DIR% (
    echo Error : %2.%3 already exists
    goto End
)

:: Start processing command
echo Creating %2.%3 package

mkdir "%NEWPKG_DIR%"

if [%1] ==[pkgAppx] (
:: Create Appx Package using template files
mkdir "%NEWPKG_DIR%\AppInstall"
copy "%IOTADK_ROOT%\Templates\AppInstall\*.cmd" "%NEWPKG_DIR%\AppInstall"
powershell -Command "(gc %IOTADK_ROOT%\Templates\AppxTemplate.pkg.xml) -replace 'COMPNAME', '%2' -replace 'SUBNAME', '%3' -replace 'PLFNAME', '%BSP_ARCH%' | Out-File %NEWPKG_DIR%\%2.%3.pkg.xml -Encoding utf8"
)
if [%1] ==[pkgDrv] (
:: Create Driver package using template files
powershell -Command "(gc %IOTADK_ROOT%\Templates\DrvTemplate.pkg.xml) -replace 'COMPNAME', '%2' -replace 'SUBNAME', '%3' -replace 'PLFNAME', '%BSP_ARCH%' | Out-File %NEWPKG_DIR%\%2.%3.pkg.xml -Encoding utf8"
)
if [%1] ==[pkgFile] (
:: Create File/Registry package using template files
powershell -Command "(gc %IOTADK_ROOT%\Templates\FileTemplate.pkg.xml) -replace 'COMPNAME', '%2' -replace 'SUBNAME', '%3' -replace 'PLFNAME', '%BSP_ARCH%' | Out-File %NEWPKG_DIR%\%2.%3.pkg.xml -Encoding utf8"
)

echo %NEWPKG_DIR% ready
goto End

:Error
endlocal
echo "newpkg %1 %2 %3 " failed with error %ERRORLEVEL%
exit /b 1

:End
endlocal
exit /b 0
