@echo off
if not defined BLD_DIR (
    echo Environment not defined. Call setenv
    exit /b 1
)
if exist %BLD_DIR% (
    del %BLD_DIR%\*.* /S /Q >nul
    echo Build directories cleaned
) else echo Nothing to clean.
exit /b 0
