@echo off
REM OEM Customization Script file

REM Enable Administrator User
net user Administrator p@ssw0rd /active:yes

if exist C:\OEMInstall\Provisioning\ProvSetA.ppkg (
	REM Applying Provisioning packages in order
	provtool C:\OEMInstall\Provisioning\ProvSetA.ppkg
	provtool C:\OEMInstall\Provisioning\ProvSetB.ppkg
	REM Cleaning up Provisioning folder
	rmdir /S /Q C:\OEMInstall
)

if exist C:\AppInstall\AppInstall.cmd (
 	REM Enable Application Installation for onetime only, after this the files are deleted.
 	call C:\Appinstall\AppInstall.cmd > %temp%\AppInstallLog.txt
	if %errorlevel%== 0 (
		REM Cleanup Application Installation Files. Change dir to root so that the dirs can be deleted
		cd \
		rmdir /S /Q C:\AppInstall
	)
)

