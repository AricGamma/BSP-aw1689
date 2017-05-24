@echo off
REM OEM Customization Script file
REM This script if included in the image, is called everytime the system boots.

REM Enable Administrator User
net user Administrator p@ssw0rd /active:yes

REM if exist C:\AppInstall\AppInstall.cmd (
REM		REM Enable Application Installation for onetime only, after this the files are deleted.
REM 	call C:\AppInstall\AppInstall.cmd > %temp%\AppInstallLog.txt
REM		if %errorlevel%== 0 (
REM			REM Cleanup Application Installation Files. Change dir to root so that the dirs can be deleted
REM			cd \
REM			rmdir /S /Q C:\AppInstall
REM		)
REM )
