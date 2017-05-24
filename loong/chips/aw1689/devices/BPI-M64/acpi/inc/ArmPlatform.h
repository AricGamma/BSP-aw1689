// Copyright (c) 2010-2014, Qualcomm Technologies Inc. All rights reserved.

#pragma once
#include <ACPI.h>
//#include <PiDxe.h> 
//#include <Acpi50.h>
  
#define EFI_ACPI_OEM_ID             'A','W','T','E','C','H'
#define EFI_ACPI_OEM_TABLE_ID       SIGNATURE_64('S','U','N','5','0','I','W','1')
#define EFI_ACPI_OEM_REVISION       0x00000000
#define EFI_ACPI_CREATOR_ID         SIGNATURE_32('A','W','T','H')
#define EFI_ACPI_CREATOR_REVISION   0x00000000

//#define ACPI_VENDOR_ID          ACPI_CREATOR_ID
#define EFI_ACPI_VENDOR_ID          SIGNATURE_32('A','W','T','H')

#define PM_PROFILE	0x08 // Type of system (8 == "Tablet")
#define SCI_INT_VECTOR  0x0000 // Ignored on ARM (i.e. EFI_ACPI_5_0_ACPI_HARDWARE_NOT_PRESENT is set in FLAG field)
#define SMI_CMD_IO_PORT 0 // Ignored on ARM
#define ACPI_ENABLE     0x000 // Ignored on ARM
#define ACPI_DISABLE    0x000 // Ignored on ARM
#define S4BIOS_REQ      0x00 // Ignored on ARM
#define PM1a_EVT_BLK    0x00000000 // Ignored on ARM
#define PM1b_EVT_BLK    0x00000000 // Ignored on ARM
#define PM1a_CNT_BLK    0x00000000 // Ignored on ARM
#define PM1b_CNT_BLK    0x00000000 // Ignored on ARM
#define PM2_CNT_BLK     0x00000000 // Ignored on ARM
#define PM_TMR_BLK      0x00000000 // Ignored on ARM
#define GPE0_BLK        0x00000000 // Ignored on ARM
#define GPE1_BLK        0x00000000 // Ignored on ARM
#define PM1_EVT_LEN     0x00 // Ignored on ARM
#define PM1_CNT_LEN     0x00 // Ignored on ARM
#define PM2_CNT_LEN     0x00 // Ignored on ARM
#define PM_TM_LEN       0x00 // Ignored on ARM
#define GPE0_BLK_LEN    0x00 // Ignored on ARM
#define GPE1_BLK_LEN    0x00 // Ignored on ARM
#define GPE1_BASE       0x00 // Ignored on ARM
#define RESERVED        0x00 // Ignored on ARM
#define P_LVL2_LAT      0x0000 // Ignored on ARM
#define P_LVL3_LAT      0x0000 // Ignored on ARM
#define FLUSH_SIZE      0x0000 // Ignored on ARM
#define FLUSH_STRIDE    0x0000 // Ignored on ARM
#define DUTY_OFFSET     0x00 // Ignored on ARM
#define DUTY_WIDTH      0x00 // Ignored on ARM
#define DAY_ALRM        0x00 // Ignored on ARM
#define MON_ALRM        0x00 // Ignored on ARM
#define CENTURY         0x00 // Ignored on ARM
#define FLAG            (EFI_ACPI_5_0_WBINVD |EFI_ACPI_5_0_SLP_BUTTON |EFI_ACPI_5_0_HW_REDUCED_ACPI |EFI_ACPI_5_0_LOW_POWER_S0_IDLE_CAPABLE)

