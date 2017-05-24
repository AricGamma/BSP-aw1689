:: Run setenv before running this script
:: This script creates the folder structure and copies the template files for a new package
@echo off

goto START

:Usage
echo Usage: newappxpkg filename.appx [CompName.SubCompName]
echo    filename.appx........... Required, Input appx package. Expects dependencies in a sub folder
echo    CompName.SubCompName.... Optional, default is Appx.filename
echo    [/?]............ Displays this usage string.
echo    Example:
echo        newappxpkg C:\test\MainAppx_1.0.0.0_arm.appx Appx.Main
echo Existing packages are
dir /b /AD %SRC_DIR%\Packages

exit /b 1

:START
setlocal ENABLEDELAYEDEXPANSION

if [%1] == [/?] goto Usage
if [%1] == [-?] goto Usage
if [%1] == [] goto Usage

set FILE_TYPE=%~x1
set FILE_NAME=%~n1
set "FILE_PATH=%~dp1"

if [%FILE_TYPE%] == [.appx] (
    set COMP_NAME=Appx
    for /f "tokens=1 delims=_" %%i in ("%FILE_NAME%") do (
        set SUB_NAME=%%i
    )
) else (
    echo. Unsupported filetype.
    goto Usage
)
if not [%2] == [] (
    for /f "tokens=1,2 delims=." %%i in ("%2") do (
        set COMP_NAME=%%i
        set SUB_NAME=%%j
    )
)

if NOT DEFINED SRC_DIR (
    echo Environment not defined. Call setenv
    goto End
)
SET "NEWPKG_DIR=%SRC_DIR%\Packages\%COMP_NAME%.%SUB_NAME%"

:: Error Checks
if /i EXIST %NEWPKG_DIR% (
    echo Error : %COMP_NAME%.%SUB_NAME% already exists
    rmdir /s /q %NEWPKG_DIR%
    echo Delete old %NEWPKG_DIR%
)

:: Start processing command
echo Creating %COMP_NAME%.%SUB_NAME% package

mkdir "%NEWPKG_DIR%"

if [%FILE_TYPE%] == [.appx] (
    :: Create Appx Package using template files
    mkdir "%NEWPKG_DIR%\AppInstall"
    echo. Creating package xml file
    call appx2pkg.cmd %1 %COMP_NAME%.%SUB_NAME%
    REM Copy the files to the package directory
    move "%FILE_PATH%\%COMP_NAME%.%SUB_NAME%.pkg.xml" "%NEWPKG_DIR%\%COMP_NAME%.%SUB_NAME%.pkg.xml" >nul
    if exist "%FILE_PATH%\Dependencies\%ARCH%" (
        copy "%FILE_PATH%\Dependencies\%ARCH%\*.appx" "%NEWPKG_DIR%\AppInstall\" >nul
    ) else (
        copy "%FILE_PATH%\Dependencies\*.appx" "%NEWPKG_DIR%\AppInstall\" >nul
    )

    copy "%FILE_PATH%\*.cer" "%NEWPKG_DIR%\AppInstall\" >nul
    copy "%FILE_PATH%\%FILE_NAME%.appx" "%NEWPKG_DIR%\AppInstall\%FILE_NAME%.appx" >nul
    copy "%IOTADK_ROOT%\Templates\AppInstall\*.cmd" "%NEWPKG_DIR%\AppInstall" >nul
    REM Update AppxConfig.cmd
    echo set AppxName=%FILE_NAME%> %NEWPKG_DIR%\AppInstall\AppxConfig.cmd
    for /f "useback delims=" %%i in ("%FILE_PATH%\appx_cerlist.txt") do (
        set certslist=!certslist!%%~ni
    )
    echo set certslist=!certslist! >> %NEWPKG_DIR%\AppInstall\AppxConfig.cmd
    for /f "useback delims=" %%i in ("%FILE_PATH%\appx_deplist.txt") do (
        set dependencylist=!dependencylist!%%~ni 
    )
    echo set dependencylist=!dependencylist! >> %NEWPKG_DIR%\AppInstall\AppxConfig.cmd
    del "%FILE_PATH%\appx_cerlist.txt"
    del "%FILE_PATH%\appx_deplist.txt"
)

echo %NEWPKG_DIR% ready
goto End

:Error
endlocal
echo "newappxpkg %1 %2" failed with error %ERRORLEVEL%
exit /b 1

:End
endlocal
exit /b 0
