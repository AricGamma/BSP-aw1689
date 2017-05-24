@echo off
if not exist %PKGLOG_DIR% ( mkdir %PKGLOG_DIR% )

echo Creating all packages under %COMMON_DIR%\Packages
dir %COMMON_DIR%\Packages\*.pkg.xml /S /b > %PKGLOG_DIR%\commonpackagelist.txt

call :SUB_PROCESSLIST %PKGLOG_DIR%\commonpackagelist.txt

echo Creating all packages under %PKGSRC_DIR%
dir %PKGSRC_DIR%\*.pkg.xml /S /b > %PKGLOG_DIR%\packagelist.txt

call :SUB_PROCESSLIST %PKGLOG_DIR%\packagelist.txt

exit /b

REM -------------------------------------------------------------------------------
REM
REM SUB_PROCESSLIST <filename>
REM
REM Processes the file list, calls createpkg for each item in the list
REM
REM -------------------------------------------------------------------------------
:SUB_PROCESSLIST

for /f "delims=" %%i in (%1) do (
   echo. Processing %%~nxi
   call createpkg.cmd %%i > %PKGLOG_DIR%\%%~ni.log
   if not errorlevel 0 ( echo. Error : Failed to create package. See %PKGLOG_DIR%\%%~ni.log )
)
exit /b