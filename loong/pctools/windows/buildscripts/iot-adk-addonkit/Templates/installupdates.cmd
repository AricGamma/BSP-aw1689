@echo off
REM Script to install the updates
net user Administrator p@ssw0rd /active:yes

SET install_dir=%~dp0
REM Getting rid of the \ at the end
SET install_dir=%install_dir:~0,-1%
cd %install_dir%
dir /b %install_dir%\*.cab > updatelist.txt
for /f "delims=" %%i in (updatelist.txt) do (
   echo Processing %%i
   call applyupdate -stage %%i
)

echo.
echo Commit updates
applyupdate -commit
