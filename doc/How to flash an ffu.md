#How to deploy a Win10 IoT ffu to a Pine64/BPI-M64 board

---

There are 3 tools that can be used to flash the ffu to a Pine64 board:

1. Using [Windows 10 IoT Dash Board][1];

2. Using "IoTCoreImageHelper" tool which is part of "IoT Core Kits";

3. Using "dism.exe" in [Windows ADK][2].

>**Notice:** In fact, both tool 1 and tool 2 depend on "dism.exe". They just provide a graphic user interface to call "dism.exe".

##1. Using Windows 10 IoT Dash Board

- Switch to "Set up a new device" tab;

- Select "Custom" option for "Device type". Click "browse" button to pick your ffu file and select a correct drive;

- Provide some provision information such as device name, password and wlan profile;

- Check the licence item box to accept the software licence and install.

>**PS:** After the progress finished, an error message "Failed to write provisioning file to microSD card" will be shown. The reason is that "IoT Dash Board" cannot write the provision configuration(device name, password & wlan profile) into microSD card. We are dealing with this issue. Please just ignore. Device name and password will be set to default.


##2. Using IoTCoreImageHelper

This tool is very simple. Just select the SD card and browse to pick image file to flash.

>**How to get this tool:** 

>Download the Raspberry Pi setup tool from [here][3] and install. Then get the "IoTCoreImageHelper" tool under the "C:\Program Files (x86)\Microsoft IoT\" directory.


##3. Using command line to call "dism.exe" directly.

- Start command prompt as an administrator;

- Insert your microSD card to your PC;

- Type "diskpart" to enter diskpart tool, then type "list disk" to show all disks;

- Note the disk ID of your microSD card(0, 1 or 2 etc);

```

DISKPART\> list disk

      Disk ###  Status         Size     Free     Dyn  Gpt
      ----------------------------------------------------
      Disk 0    Online          931 GB      0 B
      Disk 1    Online         7456 MB  5120 KB        *
  ```
  

- Type command below to flash image to SD card.

>Dism.exe /Apply-Image /ImageFile:[*ffu_path*] /ApplyDrive:\\.\PhysicalDrive[*disk_number*] /SkipPlatformCheck

>**Notice:** Please confirm the disk id seriously. It may damage your important data if flashing a wrong disk.



  [1]: https://iottools.blob.core.windows.net/iotdashboardpreview/setup.exe
  [2]: https://msdn.microsoft.com/en-us/library/windows/hardware/hh825494.aspx?f=255&MSPPError=-2147217396
  [3]: http://go.microsoft.com/fwlink/?LinkId=691711