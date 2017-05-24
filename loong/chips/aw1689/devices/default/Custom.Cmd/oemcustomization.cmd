@echo off
REM OEM Customization Script file
REM This script if included in the image, is called everytime the system boots.


REM Enable Administrator User
net user Administrator p@ssw0rd /active:yes

if exist C:\AppInstall\AppInstall.cmd (
 	REM Enable Application Installation for onetime only, after this the files are deleted.
 	call C:\AppInstall\AppInstall.cmd > C:\AppInstallLog.txt
	if %errorlevel%== 0 (
		REM Cleanup Application Installation Files. Change dir to root so that the dirs can be deleted
		cd \
		rmdir /S /Q C:\AppInstall
	)
)
