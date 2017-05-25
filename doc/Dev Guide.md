# Development Guide of Windows 10 IoT Core on A64
---

- [1. Action Supported in UEFI Process](#1)
- [2. Boot Configuration Setup](#2)
- [3. Perform Kernel Debug](#3)
- [4. Driver Development for Windows 10 IoT Core](#4)
- [5. App Development for Windows 10 IoT Core](#5)



<h2 id="1">1. Action supported in UEFI process</h2>

After the image deployment ( How to flash ffu, refer to [here](https://github.com/Leeway213/Win10-IoT-for-A64-Release-Notes/blob/master/doc/How%20to%20flash%20ffu.md) ), once power on, a boot process can be splitted into two steps: UEFI Process and Windows OS bring-up Process.

After power cable plugs in, UEFI binaries in boot partition run to act some hardware initialization and subsequently find Windows OS routine to bring up.

Connect to on-board UART0 with serial cable and open a serial terminal such as XShell or SecureCRT. Start a session with parameters: 

```
Baudrate: 115200
Data Bits: 8
Stop Bits: 1
Parity: None
Flow Control: None
```
During UEFI Process, you can see the boot logs in terminal and can act several options below:

1. Hold number "1", to boot to mass storage mode. 

    In this mode, you can mount all partitions on-board to your dev PC via a USB cable.
    > For PINE64, use a two-side USB type A cable and plug it in the upper USB A interface; For BPI-M64, use a USB type A to microUSB cable and microUSB interface on board.

2. Hold number "2", to boot to fel mode.

    If you need to flash UEFI image via PhoenixSuit, this command can make CPU jump to fel mode in which PhoenixSuit can communicate with board.

3. Hold number "4", to boot to UEFI shell.

    In UEFI shell, you can execute some UEFI specific command to do something such as dump registers or write new value into it.

> PS: Command number "3" and "4" are for test or unuseful right now.

After UEFI process find and execute Windows OS boot routine, the UART will be taken over by Windows OS and you cannot do anything in serial terminal.


<h2 id="2">2. Boot Configuration Setup</h2>

Windows 10 IoT Core stores some specific configuration data with a Boot Configuration Data(BCD) file, which is the same with Windows 10 PC and Mobile OS.

The BCD file of Windows 10 IoT Core can be found at `C:\EFIESP\EFI\Microsoft\boot\BCD`. You can query or modify it by a host computer's or on-board `bcdedit` tool, using host computer to query or modify in a mass storage mode and on-board tool in an SSH session.

The following shows several command of `bcdedit` you can use to turn on or off kernel debug and change debug connection type:

1. Enumarate all configurations

    `bcdedit /store [BCD file path] /enum all`

2. Turn on or off kernel debug

    `bcdedit /store [BCD file path] /set {default} debug on`

3. Set debug connection type to serial

    `bcdedit /store [BCD file path] /dbgsettings serial debugport:[COM number] baudrate:57600`
    
    It should be a number following a `debugport` option which is determined by which COM port of your host computer is connected to on-board UART0. The `baudrate` option must be "57600" for PINE64 and BPI-M64 boards.

4. Set debug connection type to net

    `bcdedit /store [BCD file path] /dbgsettings net hostip:1.2.3.4 port:50000 key:1.2.3.4`

    In this sample, the `hostip` parameter is followed by a weird number "1.2.3.4". This represents board can find a right host number in local network automatically. Of cause you can fill it in a specified ip address of your host computer such as "192.168.2.222".


<h2 id="3">3. Perform Kernel Debug</h2>

To perform a kernel debug, the Debugging Tools for Windows (WinDbg) is necessary and navigate to [here](https://developer.microsoft.com/en-us/windows/hardware/windows-driver-kit) to download.

Before connecting WinDbg with your board, choose a debug connection type you want to use and modify the on-board BCD following the introduction in section 2.

### 1. Debug with serial connection

1. Setup debug settings in on-board BCD to serial. Refer to [section 2](#2).

2. Open WinDbg with parameters like this:

    `WinDbg.exe -k com:port=[ComPort],baud=[BaudRate]`

    The parameters of `ComPort` and `BaudRate` need to be the same with parameters of `debugport` and `baudrate` in debug settings of BCD.

3. Then reset your board and perform a kernel debug.

### 2. Debug with a virtual net over USB

A kdnet over USB driver is built-in in PINE64 and BPI-M64 Windows 10 IoT Core BSP. It has much better performance than debug with a serial connection.

To perform kernel debug with virtual net over USB, please follow steps bellow:

1. Enable "Hyper-V" feature in Control Panel.

![Enable Hyper-V](https://github.com/Leeway213/BSP-aw1689/blob/master/doc/Images/Enable%20Hyper-V.jpg)

2. Create a virtual switch in Hyper-V's Virtual Switch Manager which is necessary to bridge local network adapter of host computer and on-board virtual network over USB.

![Hyper-V](https://github.com/Leeway213/BSP-aw1689/blob/master/doc/Images/Hyper-V.jpg)

![Virtual Switch Manager](https://github.com/Leeway213/BSP-aw1689/blob/master/doc/Images/virtual%20switch%20manager.jpg)

3. Setup debug settings in on-board BCD to net and specify a host ip, port number and a key. Refer to the forth description in [section 2](#2).

4. Download a tool named "VirtEth.exe" [here](https://github.com/Leeway213/BSP-aw1689/tree/master/loong/pctools/windows/VirtEth). If you are using a Windows 10 PC with version 10.0.10586.0 or earlier, the one named "VirtEth_TH2.exe" is available. And else please download the "VirtEth_RS1.exe" one.

5. Run the tool in step 4. 
If you didn't specify a static ip address of host computer such as "192.168.2.222", but used "1.2.3.4" instead, run "VirtEth" with parameter "/autodebug":

    `VirEth.exe /autodebug`

6. Open WinDbg with parameters like this:

    `WinDbg.exe -k net:port=[port number],key=[key]`

    The parameters of `port` and `key` need to be the same with parameters of `port` and `key` in debug settings of on-board BCD which is configurated in step 3.

7. Reset your board and perform a kernel debug with virtual net over USB.


#### For more information about Windows debugging, a detail document is shown in [msdn](https://msdn.microsoft.com/en-us/library/windows/hardware/mt219729(v=vs.85).aspx).


<h2 id="4"> 4. Driver Development for Windows 10 IoT Core</h2>

Universal Windows drivers enable developers to create a single driver that runs across multiple different device types, from embedded systems to tablets and desktop PCs. Hardware developers can use their existing components and device drivers across different form factors. Universal Windows drivers run on Windows 10 for desktop editions (Home, Pro, and Enterprise), Windows 10 Mobile, Windows 10 IoT Core, Windows Server 2016 Technical Preview, as well as other Windows 10 editions that share a common set of interfaces.

For information about how to develop Windows drivers for UWP, see [Windows Driver dev guide](https://docs.microsoft.com/en-us/windows-hardware/drivers/develop/).

Here are some [general driver samples](https://github.com/Microsoft/Windows-driver-samples) and [Allwinner A64 featured driver samples](https://github.com/Leeway213/driver-samples).


<h2 id="5">5. App Development for Windows 10 IoT Core</h2>

Windows 10 IoT Core supports three kinds of application types. UWP headed, UWP headless and win32 console application compiled to ARM architecture.

Microsoft has provided very detailed [documents on WindowsOnDevices website](https://developer.microsoft.com/en-us/windows/iot/Docs) and [code samples on Github](https://github.com/ms-iot/samples).

