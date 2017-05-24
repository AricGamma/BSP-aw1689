@echo off
goto START

:USAGE
echo Usage: setenv arch
echo    arch....... Required, %SUPPORTED_ARCH%
echo    [/?]........Displays this usage string.
echo    Example:
echo        setenv arm

exit /b 1

:START

if [%1] == [/?] goto USAGE
if [%1] == [-?] goto USAGE
if [%1] == [] goto USAGE

set SUPPORTED_ARCH=arm x86 x64
echo.%SUPPORTED_ARCH% | findstr /C:"%1" >nul && (
    echo Configuring for %1 architecture
) || (
    echo.Error: %1 not supported
    goto USAGE
)

REM Environment configurations
set PATH=%KITSROOT%tools\bin\i386;%PATH%
set AKROOT=%KITSROOT%
set WPDKCONTENTROOT=%KITSROOT%
set PKG_CONFIG_XML=%KITSROOT%Tools\bin\i386\pkggen.cfg.xml

set ARCH=%1
set BSP_ARCH=%1
set HIVE_ROOT=%KITSROOT%CoreSystem\%WDK_VERSION%\%BSP_ARCH%
set WIM_ROOT=%KITSROOT%CoreSystem\%WDK_VERSION%\%BSP_ARCH%

if [%1] == [x64] ( set BSP_ARCH=amd64)
REM The following variables ensure the package is appropriately signed
set SIGN_OEM=1
set SIGN_WITH_TIMESTAMP=0


REM Local project settings
set COMMON_DIR=%IOTADK_ROOT%\Common
set SRC_DIR=%IOTADK_ROOT%\Source-%1
set PKGSRC_DIR=%SRC_DIR%\Packages
set BSPSRC_DIR=%SRC_DIR%\BSP
set PKGUPD_DIR=%SRC_DIR%\Updates
set BLD_DIR=%IOTADK_ROOT%\Build\%BSP_ARCH%
set PKGBLD_DIR=%BLD_DIR%\pkgs
set PKGLOG_DIR=%PKGBLD_DIR%\logs
set TOOLS_DIR=%IOTADK_ROOT%\Tools

call setversion.cmd

set PROMPT=IoTCore %BSP_ARCH% %BSP_VERSION%$_$P$G
TITLE IoTCoreShell %BSP_ARCH% %BSP_VERSION%

echo BSP_ARCH    : %BSP_ARCH%
echo BSP_VERSION : %BSP_VERSION%
echo.

exit /b 0
