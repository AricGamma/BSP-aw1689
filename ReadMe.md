# Windows 10 IoT BSP for Allwinner aw1689(A64) SoC

---

## Introduction

This project introduces how to develop, build, customize and package a Windows 10 IoT Core BSP for boards based on Allwinner aw1689(A64) SoC.
Main contents:
1. UEFI binaries for boot
2. Core driver binaries for Allwinner A64
3. Scripts for compiling, packaging and building `.ffu` image
4. FeatureManifest configration files for building `.ffu` image

## Directory

- [1. Directory Tree](#1)
- [2. How to Build](#2)
- [3. How to Deploy](#3)
- [4. Known Issues](#4)

<h2 id="1">1. Directory Tree</h2>

        Root
          |-- .\loong                                         Contains scipts&configuration files for building ffu
          *    |-- .\chips                                    
          *    *    |-- .\aw1689                              aw1689(A64) model
          *    *    *    |-- .\bin    
          *    *    *    *    |-- .\EFI                       Boot Configuration Data(BCD)
          *    *    *    *    |-- *.bin                       Legacy binaries
          *    *    *    |-- .\boot-resource                  boot resources(legacy)
          *    *    *    |-- .\devices                        Feature manifest & ACPI table
          *    *    *    *    |-- .\BPI-M64                   Configurations for BananaPi M64
          *    *    *    *    *    |-- .\acpi                 ACPI source code and generation directory
          *    *    *    *    *    *    |-- .\ACPI            ACPI generation directory
          *    *    *    *    *    *    |-- .\inc             Includes
          *    *    *    *    *    *    |-- .\src             Source code
          *    *    *    *    *    |-- .\logo                 Logo shown when boot
          *    *    *    *    *    |-- DeviceFM.xml           Main device feature manifest(FM)
          *    *    *    *    *    |-- DeviceInfo.pkg.xml     Pkg for device information
          *    *    *    *    *    |-- DeviceLayout.xml       Partion configuration
          *    *    *    *    *    |-- DevicePlatform.xml     Platform information
          *    *    *    *    *    |-- OemInput_RetailOS.xml  FM file for building retail image
          *    *    *    *    *    |-- OemInput_TestOS.xml    FM file for building test image
          *    *    *    *    |-- .\default                   Common configurations and ACPI for aw1689 platform
          *    *    *    *    |-- .\dingdong                  Test-inside board model
          *    *    *    *    |-- .\perf2_v1_0                Test-inside board model
          *    *    *    *    |-- .\pine64                    Pine64 board
          *    *    *    *    |-- .\r18                       Test-inside board model
          *    *    *    |-- .\tools                          Some tools(legacy)
          *    |-- .\common                                   Some common files(legacy)
          *    |-- .\ffu                                      Directory for image generation
          *    |-- .\pctools                                  Scripts & tools for compiling, packaging and deploying
          *    *    |-- .\linux                               Scripts and tools in Linux(legacy)
          *    *    |-- .\windows                             Scripts and tools in Windows
          *    *    *    |-- .\acpi                           
          *    *    *    *    |-- .\acpi_extract.exe          Tools for extracting acpi
          *    *    *    |-- .\buildscripts                   
          *    *    *    *    |-- .\iot-adk-addonkit          Reference from (https://github.com/ms-iot/iot-adk-addonkit)
          *    *    *    *    |-- BuildAllAppx.cmd            Build apps under .\src\app directory
          *    *    *    *    |-- BuildAllComponent.cmd       Build all component
          *    *    *    *    |-- BuildBootloader.cmd         Build bootloader(unused)
          *    *    *    *    |-- BuildWindowsDrivers.cmd     Build drivers and generate cabs
          *    *    *    *    |-- PackAppx.cmd                Generate cabs for appx
          *    *    *    *    |-- PackBootloader.cmd          Package bootloader
          *    *    *    *    |-- PackBootresource.cmd        Package resources for boot
          *    *    *    *    |-- PackDeviceConfigs.cmd       Package configuration files of device
          *    *    *    *    |-- PackFfu.cmd                 Generate ffu image
          *    *    *    |-- .\UefiUpgrade                    Update UEFI binary separately
          *    *    *    |-- .\VirEth                         Debug tools for bridging virtual ethernet and USB
          *    *    *    *    |-- VirEth_TH2.exe              For Build 10586 1511 and previous version
          *    *    *    *    |-- VirEth_RS1.exe              For Build 14393 1607 and later version
          *    |-- .\prebuilt                                 Contains generated cabs and UEFI binaries for building ffu image
          *    *    |-- .\aw1689                              Allwinner (aw1689)A64
          *    *    *    |-- .\CabPackages                    Common packages for aw1689 platform
          *    *    *    |-- .\devices                        Packages for differnent boards based on aw1689
          |-- Build.cmd                                       Build entry
          |-- SetBuildEnv.cmd                                 Set environment variables for building(called by Build.cmd)

<h2 id="2">2. How to Build</h2>

### 1. Preparation before building

(1). Update OS of your PC to Windows 10 1703(build 15063) and ensure that there is enough space to install visual studio, WDK, SDK and ADK in your system partion(50GB at least).

(2). Install [Visual Studio 2015](https://www.visualstudio.com)

> PS: Please check Universal Windows App Development Tools and its sub options and don't change the location for installation.

(3). Install [Windows 10 Driver Kits(WDK)](https://developer.microsoft.com/zh-cn/windows/hardware/windows-driver-kit)

(4). Install [Windows ADK for Windows 10](https://developer.microsoft.com/en-us/windows/hardware/windows-assessment-deployment-kit)

(5). Install [Windows 10 IoT Core Kits iso](https://msdn.microsoft.com/subscriptions/json/GetDownloadRequest?brand=MSDN&locale=en-us&fileId=72005&activexDisabled=true&akamaiDL=false) in MSDN subscription center.

> PS: You need an account with msdn subscription

### 2. Compile drivers

Run Visual Studio as Administrator. Select "File -> Open -> Project/Solution" in menu and select `.\src\build\aw1689.sln` solution file in explorer. Build solution and find generated drivers and cabs under `.\src\build\ARM` directory.

Learn how to develop Windows driver, please visit [here](https://msdn.microsoft.com/windows/hardware/drivers/develop/getting-started-with-universal-drivers) and [samples on github](https://github.com/Microsoft/Windows-driver-samples).

### 3. Build default app(UWP)

Open `.\src\app\IoTDefaultApp\IoTCoreDefaultApp.sln` with Visual Studio and build solution.

Learn how to develop apps for Universal Windows Platform, please visit [here](https://developer.microsoft.com/zh-cn/windows/apps/getstarted) and [samples on github](https://github.com/ms-iot/samples).

### 4. Generate ffu image

Learn how to customize your IoT Core image, please visit [here](https://msdn.microsoft.com/zh-cn/windows/hardware/commercialize/manufacture/iot/index).

For your easy reference, we provide a serious of scripts to help to generate ffu. You can just run `Build.cmd` under root directory of the project and type a right number to excute any compiling or building operations.

> For example: Type "1" to build all drivers and apps and package ffu image.

**<font color="red">Attention: Before excuting the operation of generating ffu, ensure that you have remove all mass storage devices(USB disks or SD card) from your computer again and again. Because the `dism.exe` called by script will destroy your data in these devices!</font>**

After ffu generation complete, you can get the `.ffu` image file under `.\loong\ffu` for your board.

> To change a board model, please modify the `DeviceName` variable in `SetBuidEnv.cmd` script.(Pine64 or BPI-M64)

For more information about developing and debugging Windows 10 IoT Core on Allwinner A64 platform, see [
Development Guide of Windows 10 IoT Core on A64](https://github.com/Leeway213/BSP-aw1689/blob/master/doc/Dev%20Guide.md).

<h2 id="3">3. How to Deploy</h2>

Please refer to [How to Flash FFU](https://github.com/Leeway213/Win10-IoT-for-A64-Release-Notes/blob/master/doc/How%20to%20flash%20ffu.md).

<h2 id="4">4. Known Issues</h2>

### Issues on all boards:
1. Bluetooth is not available;
2. Hot plug of USB is not supported.
3. Ethernet has a good TX performance but poor on RX.


### Issues on PINE64:
1. USB cannot be used directly without a USB hub plugging in as medium;
2. Wlan has a good TX performance but poor on RX;
3. The upper USB interface is configured to Device Mode which is used for virtual kernel debug net over USB.

### Issues on BPI-M64:
1. WiFi is not available.

### Issues on NanoPi-A64:
1. The same as PINE64, wlan has a good TX performane but poor on RX; 
2. The wlan device cannot be enabled after soft reboot until cutting off the power and re-power;
3. The upper USB interface is configured to Device Mode which is used for virtual kernel debug net over USB.