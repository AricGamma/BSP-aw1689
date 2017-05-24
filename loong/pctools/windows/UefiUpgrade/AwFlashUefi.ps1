#include "AwGetDisk.ps1"

$pwd = $PSScriptRoot
$subdir =  Split-Path -Parent $pwd
$dir =  Split-Path -Parent $subdir
$root = Split-Path -Parent $dir
$filedir = Split-Path -Parent $root

$content = (get-content $filedir\SetBuildEnv.cmd -TotalCount 3)[-1]
$len = $content.length - 12
$chipname = $content.Substring(12, $len)

$content = (get-content $filedir\SetBuildEnv.cmd -TotalCount 4)[-1]
$len = $content.length - 15
$devname = $content.Substring(15, $len)

Write-host uefi image location at \prebuilt\$chipname\devices\$devname\bin

. $pwd"\AwGetDisk.ps1"	

$indx = AllwinnerGetDiskNumber

if($indx -le 0)
{
	Write-host "Can't find uefi partition"
	return
}

Write-host Write UEFI to disk $indx
& $pwd"\dd" if=$root"\prebuilt\$chipname\devices\$devname\bin\boot_package.fex" of=\\?\device\harddisk$indx\partition2
