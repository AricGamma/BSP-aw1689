@echo off
:: Environment configurations

if NOT [%1] == [] (
REM TODO Insert version format validation
SET BSP_VERSION=%1
) else (
    if exist %PKGSRC_DIR%\versioninfo.txt (
        SET /P BSP_VERSION=< %PKGSRC_DIR%\versioninfo.txt
    ) else (
        SET BSP_VERSION=10.0.0.0
        echo. %PKGSRC_DIR%\versioninfo.txt not found. Defaulting to 10.0.0.0
    )
)

echo %BSP_VERSION%> %PKGSRC_DIR%\versioninfo.txt

set PROMPT=IoTCore %BSP_ARCH% %BSP_VERSION%$_$P$G
TITLE IoTCoreShell %BSP_ARCH% %BSP_VERSION%