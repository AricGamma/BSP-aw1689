@echo off

goto :START

:Usage
echo Usage: createupdatepkgs updatename
echo    updatename....... Name of the update directory under Updates
echo    [/?]........Displays this usage string.
echo    Example:
echo        createupdatepkgs Update1

exit /b 1

:START

setlocal
if [%1] == [/?] goto Usage
if [%1] == [-?] goto Usage
if [%1] == [] goto Usage
set UPDATE=%1
if NOT exist "%PKGUPD_DIR%\%UPDATE%" (
echo %1 does not exist. Available updates are
dir /B /AD %PKGUPD_DIR%
echo.
goto END
)

if exist "%PKGUPD_DIR%\%UPDATE%\versioninfo.txt" (
    SET /P PKG_VER=< %PKGUPD_DIR%\%UPDATE%\versioninfo.txt
) else (
    echo Error :%PKGUPD_DIR%\%UPDATE%\versioninfo.txt not found.
    echo        Please specify version in versioninfo.txt
    goto End
)
SET PKGBLD_DIR=%BLD_DIR%\%UPDATE%
echo Creating Update packages for %PKGUPD_DIR%\%UPDATE% using version : %PKG_VER%

dir "%PKGUPD_DIR%\%UPDATE%\*.pkg.xml" /S /b > updatepackagelist.txt

for /f "delims=" %%i in (updatepackagelist.txt) do (
   echo Processing %%i
   call createpkg.cmd %%i %PKG_VER%
)
del updatepackagelist.txt

REM always rebuild the version packages
call createpkg.cmd %COMMON_DIR%\Packages\Registry.Version\Registry.Version.pkg.xml %PKG_VER%
copy "%IOTADK_ROOT%\Templates\installupdates.cmd" "%PKGBLD_DIR%\installupdates.cmd"


:END
endlocal
exit /b 0
