:: Run setenv before running this script
:: This script creates the folder structure and copies the template files for a new product
:: usage : newbsp <bsp name>
@echo off

goto START

:Usage
echo Usage: newbsp BSPName
echo    BSPName........... Required, Name of the BSP to be used
echo    [/?].............. Displays this usage string.
echo    Example:
echo        newbsp CustomRPi2
echo Existing BSPs are
dir /b /AD %SRC_DIR%\BSP

exit /b 1

:START
setlocal

if [%1] == [/?] goto Usage
if [%1] == [-?] goto Usage
if [%1] == [] goto Usage

if not defined SRC_DIR (
    echo Environment not defined. Call setenv
    goto End
)
:: Error Checks
SET NEWBSP=%1
SET NEWBSP_DIR=%BSPSRC_DIR%\%NEWBSP%

if /i exist %NEWBSP_DIR% (
    echo Error : %1 already exists
    goto Usage
)

:: Start processing command
echo Creating %1 BSP

mkdir "%NEWBSP_DIR%"
mkdir "%NEWBSP_DIR%\Packages"
mkdir "%NEWBSP_DIR%\OEMInputSamples"

powershell -Command "(gc %SRC_DIR%\Templates\RetailOEMInputTemplate.xml) -replace '{BSP}', '%NEWBSP%' -replace '{arch}', '%BSP_ARCH%' | Out-File %NEWBSP_DIR%\OEMInputSamples\RetailOEMInput.xml -Encoding utf8"
powershell -Command "(gc %SRC_DIR%\Templates\TestOEMInputTemplate.xml) -replace '{BSP}', '%NEWBSP%' -replace '{arch}', '%BSP_ARCH%' | Out-File %NEWBSP_DIR%\OEMInputSamples\TestOEMInput.xml -Encoding utf8"
powershell -Command "(gc %SRC_DIR%\Templates\SampleFM.xml) -replace '{BSP}', '%NEWBSP%' -replace '{arch}', '%BSP_ARCH%' | Out-File %NEWBSP_DIR%\Packages\%NEWBSP%FM.xml -Encoding utf8"

echo %1 BSP directories ready
goto End


:Error
endlocal
echo "newbsp %1 " failed with error %ERRORLEVEL%
exit /b 1

:End
endlocal
exit /b 0
