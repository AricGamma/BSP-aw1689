:: Run setenv before running this script
:: This script creates the folder structure and copies the template files for a new package
@echo off

goto START

:Usage
echo Usage: newdrvpkg filename.inf [CompName.SubCompName]
echo    filename.inf............ Required, input inf file
echo    CompName.SubCompName.... Optional, default is Drivers.filename
echo    [/?]............ Displays this usage string.
echo    Example:
echo        newpkg C:\test\testdrv.inf Drivers.MyDriver
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
set FILE_PATH=%~dp1


if [%FILE_TYPE%] == [.inf] (
    set COMP_NAME=Drivers
    set SUB_NAME=%FILE_NAME%
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
SET NEWPKG_DIR=%SRC_DIR%\Packages\%COMP_NAME%.%SUB_NAME%

:: Error Checks
if /i EXIST %NEWPKG_DIR% (
    echo Error : %COMP_NAME%.%SUB_NAME% already exists
    goto End
)

:: Start processing command
echo Creating %COMP_NAME%.%SUB_NAME% package

mkdir "%NEWPKG_DIR%"

if [%FILE_TYPE%] == [.inf] (
    REM Create Pkgxml from inf file
    echo. Creating package xml file
    call inf2pkg.cmd %1 %COMP_NAME%.%SUB_NAME%
    REM copy the files to the package directory
    echo. Copying files to package directory
    move "%FILE_PATH%\%COMP_NAME%.%SUB_NAME%.pkg.xml" "%NEWPKG_DIR%\%COMP_NAME%.%SUB_NAME%.pkg.xml" >nul
    copy "%FILE_PATH%\%FILE_NAME%.inf" "%NEWPKG_DIR%\%FILE_NAME%.inf" >nul
    for /f "delims=" %%i in (%FILE_PATH%\inf_filelist.txt) do (
        if exist "%FILE_PATH%%%i" (
            copy "%FILE_PATH%%%i" "%NEWPKG_DIR%\%%i" >nul
        )
    )
    move "%FILE_PATH%\inf_filelist.txt" "%NEWPKG_DIR%\inf_filelist.txt" >nul
)

echo %NEWPKG_DIR% ready
goto End

:Error
endlocal
echo "newpkg %1 %2" failed with error %ERRORLEVEL%
exit /b 1

:End
endlocal
exit /b 0
