@echo off

goto START

:Usage
echo Usage: createimage ProductName BuildType
echo    ProductName....... Required, Name of the product to be created.
echo    BuildType......... Required, Retail/Test
echo    [/?].............. Displays this usage string.
echo    Example:
echo        createimage SampleA Retail

exit /b 1

:START
setlocal
REM Input validation
if [%1] == [/?] goto Usage
if [%1] == [-?] goto Usage
if [%1] == [] goto Usage
if [%2] == [] goto Usage
if /I NOT [%2] == [Retail] ( if /I NOT [%2] == [Test] goto Usage )

REM Checking prerequisites
if NOT DEFINED SRC_DIR (
    echo Environment not defined. Call setenv
    goto End
)

set PRODUCT=%1
set PRODSRC_DIR=%SRC_DIR%\Products\%PRODUCT%
set PRODBLD_DIR=%BLD_DIR%\%1\%2
if not defined MSPACKAGE ( set "MSPACKAGE=%KITSROOT%MSPackages" )

if NOT exist %SRC_DIR%\Products\%PRODUCT% (
   echo %PRODUCT% not found. Available products listed below
   dir /b /AD %SRC_DIR%\Products
   goto Usage
)
REM Start processing command
echo Creating %1 %2 Image
echo Build Start Time : %TIME%

echo Building Packages with product specific contents
call buildpkg.cmd Custom.Cmd

if NOT exist %PRODSRC_DIR%\prov\%PRODUCT%Prov.ppkg (
 REM Create the provisioning ppkg
 call createprovpkg.cmd %PRODSRC_DIR%\prov\customizations.xml %PRODSRC_DIR%\prov\%PRODUCT%Prov.ppkg
)
call buildpkg.cmd Provisioning.Auto

echo Creating Image...
call imggen.cmd "%PRODBLD_DIR%\Flash.FFU" "%PRODSRC_DIR%\%2OEMInput.xml" "%MSPACKAGE%" %BSP_ARCH%

if errorlevel 1 goto Error

echo Build End Time : %TIME%
echo Image creation completed
goto End

:Error
endlocal
echo "CreateImage %1 %2" failed with error %ERRORLEVEL%
exit /b 1

:End
endlocal
exit /b 0