
#pragma once

typedef unsigned char       UINT8;
typedef unsigned short      UINT16;
typedef unsigned int        UINT32;
typedef unsigned long long  UINT64;
typedef void                VOID;

#define  BIT0     0x00000001
#define  BIT1     0x00000002
#define  BIT2     0x00000004
#define  BIT3     0x00000008
#define  BIT4     0x00000010
#define  BIT5     0x00000020
#define  BIT6     0x00000040
#define  BIT7     0x00000080
#define  BIT8     0x00000100
#define  BIT9     0x00000200
#define  BIT10    0x00000400
#define  BIT11    0x00000800
#define  BIT12    0x00001000
#define  BIT13    0x00002000
#define  BIT14    0x00004000
#define  BIT15    0x00008000
#define  BIT16    0x00010000
#define  BIT17    0x00020000
#define  BIT18    0x00040000
#define  BIT19    0x00080000
#define  BIT20    0x00100000
#define  BIT21    0x00200000
#define  BIT22    0x00400000
#define  BIT23    0x00800000
#define  BIT24    0x01000000
#define  BIT25    0x02000000
#define  BIT26    0x04000000
#define  BIT27    0x08000000
#define  BIT28    0x10000000
#define  BIT29    0x20000000
#define  BIT30    0x40000000
#define  BIT31    0x80000000

//
// Multiple APIC Description Table APIC structure types
// All other values between 0x0D and 0x7F are reserved and
// will be ignored by OSPM. 0x80 ~ 0xFF are reserved for OEM.
//
#define EFI_ACPI_5_0_PROCESSOR_LOCAL_APIC           0x00
#define EFI_ACPI_5_0_IO_APIC                        0x01
#define EFI_ACPI_5_0_INTERRUPT_SOURCE_OVERRIDE      0x02
#define EFI_ACPI_5_0_NON_MASKABLE_INTERRUPT_SOURCE  0x03
#define EFI_ACPI_5_0_LOCAL_APIC_NMI                 0x04
#define EFI_ACPI_5_0_LOCAL_APIC_ADDRESS_OVERRIDE    0x05
#define EFI_ACPI_5_0_IO_SAPIC                       0x06
#define EFI_ACPI_5_0_LOCAL_SAPIC                    0x07
#define EFI_ACPI_5_0_PLATFORM_INTERRUPT_SOURCES     0x08
#define EFI_ACPI_5_0_PROCESSOR_LOCAL_X2APIC         0x09
#define EFI_ACPI_5_0_LOCAL_X2APIC_NMI               0x0A
#define EFI_ACPI_5_0_GIC                            0x0B
#define EFI_ACPI_5_0_GICD                           0x0C

//
// General use definitions
//
#define EFI_ACPI_RESERVED_BYTE  0x00
#define EFI_ACPI_RESERVED_WORD  0x0000
#define EFI_ACPI_RESERVED_DWORD 0x00000000
#define EFI_ACPI_RESERVED_QWORD 0x0000000000000000

#define ACPI_RESERVED       0

#pragma pack(1)

typedef struct {
  UINT32  Signature;
  UINT32  Length;
  UINT8   Revision;
  UINT8   Checksum;
  UINT8   OemId[6];
  UINT64  OemTableId;
  UINT32  OemRevision;
  UINT32  CreatorId;
  UINT32  CreatorRevision;
} EFI_ACPI_DESCRIPTION_HEADER;

///
/// Boot Graphics Resource Table definition.
///
typedef struct {
  EFI_ACPI_DESCRIPTION_HEADER Header;
  ///
  /// 2-bytes (16 bit) version ID. This value must be 1.
  ///
  UINT16                      Version;
  ///
  /// 1-byte status field indicating current status about the table.
  ///     Bits[7:1] = Reserved (must be zero)
  ///     Bit [0] = Valid. A one indicates the boot image graphic is valid.
  ///
  UINT8                       Status;
  ///
  /// 1-byte enumerated type field indicating format of the image.
  ///     0 = Bitmap
  ///     1 - 255  Reserved (for future use)
  ///
  UINT8                       ImageType;
  ///
  /// 8-byte (64 bit) physical address pointing to the firmware's in-memory copy
  /// of the image bitmap.
  ///
  UINT64                      ImageAddress;
  ///
  /// A 4-byte (32-bit) unsigned long describing the display X-offset of the boot image.
  /// (X, Y) display offset of the top left corner of the boot image.
  /// The top left corner of the display is at offset (0, 0).
  ///
  UINT32                      ImageOffsetX;
  ///
  /// A 4-byte (32-bit) unsigned long describing the display Y-offset of the boot image.
  /// (X, Y) display offset of the top left corner of the boot image.
  /// The top left corner of the display is at offset (0, 0).
  ///
  UINT32                      ImageOffsetY;
} EFI_ACPI_5_0_BOOT_GRAPHICS_RESOURCE_TABLE;

#define ACPI_GAS_ID_SYSTEM_MEMORY              0
#define ACPI_GAS_ID_SYSTEM_IO                  1
#define ACPI_GAS_ID_PCI_CONFIGURATION_SPACE    2
#define ACPI_GAS_ID_EMBEDDED_CONTROLLER        3
#define ACPI_GAS_ID_SMBUS                      4
#define ACPI_GAS_ID_FUNCTIONAL_FIXED_HARDWARE  0x7F


#define EFI_ACPI_5_0_FIXED_ACPI_DESCRIPTION_TABLE_REVISION  0x05
#define EFI_ACPI_5_0_GENERIC_TIMER_DESCRIPTION_TABLE_REVISION 0x01
#define EFI_ACPI_1_0_MULTIPLE_APIC_DESCRIPTION_TABLE_REVISION 0x01


//
// GTDT flag definitions
//
#define GTDT_TIMER_EDGE_TRIGGERED  0x00000001
#define GTDT_TIMER_ACTIVE_LOW      0x00000002
#define GTDT_TIMER_ALWAYS_ON       0x00000004
                       
 
#define SIGNATURE_16(A, B)        ((A) | (B << 8))
#define SIGNATURE_32(A, B, C, D)  (SIGNATURE_16 (A, B) | (SIGNATURE_16 (C, D) << 16))
#define SIGNATURE_64(A, B, C, D, E, F, G, H) \
    (SIGNATURE_32 (A, B, C, D) | ((UINT64) (SIGNATURE_32 (E, F, G, H)) << 32))
    
#define ACPI_FACP_SIGNATURE  SIGNATURE_32('F', 'A', 'C', 'P')
#define ACPI_FACS_SIGNATURE  SIGNATURE_32('F', 'A', 'C', 'S')
#define ACPI_DBGP_SIGNATURE  SIGNATURE_32('D', 'B', 'G', 'P')
#define ACPI_DBG2_SIGNATURE  SIGNATURE_32('D', 'B', 'G', '2')
#define ACPI_CSRT_SIGNATURE  SIGNATURE_32('C', 'S', 'R', 'T')
#define ACPI_APIC_SIGNATURE  SIGNATURE_32('A', 'P', 'I', 'C')
#define ACPI_BGRT_SIGNATURE  SIGNATURE_32('B', 'G', 'R', 'T')
#define ACPI_GTDT_SIGNATURE  SIGNATURE_32('G', 'T', 'D', 'T')
#define ACPI_TPM2_SIGNATURE  SIGNATURE_32('T', 'P', 'M', '2')
#define ACPI_FPDT_SIGNATURE  SIGNATURE_32('F', 'P', 'D', 'T')
#define ACPI_MCFG_SIGNATURE  SIGNATURE_32('M', 'C', 'F', 'G')
#define ACPI_FACP_REVISION   0x05
#define ACPI_BGRT_REVISION   0x01
#define ACPI_FPDT_REVISION   0x01
#define ACPI_CSRT_REVISION   0x00
#define ACPI_TPM2_REVISION   0x03
#define ACPI_TPM2_QCOM_START_METHOD           0x9
#define ACPI_GTDT_REVISION   0x02


///
/// ACPI 5.0 Generic Address Space definition
///
typedef struct {
  UINT8   AddressSpaceId;
  UINT8   RegisterBitWidth;
  UINT8   RegisterBitOffset;
  UINT8   AccessSize;
  UINT64  Address;
} EFI_ACPI_5_0_GENERIC_ADDRESS_STRUCTURE;

//
// Fixed ACPI Description Table Fixed Feature Flags
// All other bits are reserved and must be set to 0.
//
#define EFI_ACPI_5_0_WBINVD                                 BIT0
#define EFI_ACPI_5_0_WBINVD_FLUSH                           BIT1
#define EFI_ACPI_5_0_PROC_C1                                BIT2
#define EFI_ACPI_5_0_P_LVL2_UP                              BIT3
#define EFI_ACPI_5_0_PWR_BUTTON                             BIT4
#define EFI_ACPI_5_0_SLP_BUTTON                             BIT5
#define EFI_ACPI_5_0_FIX_RTC                                BIT6
#define EFI_ACPI_5_0_RTC_S4                                 BIT7
#define EFI_ACPI_5_0_TMR_VAL_EXT                            BIT8
#define EFI_ACPI_5_0_DCK_CAP                                BIT9
#define EFI_ACPI_5_0_RESET_REG_SUP                          BIT10
#define EFI_ACPI_5_0_SEALED_CASE                            BIT11
#define EFI_ACPI_5_0_HEADLESS                               BIT12
#define EFI_ACPI_5_0_CPU_SW_SLP                             BIT13
#define EFI_ACPI_5_0_PCI_EXP_WAK                            BIT14
#define EFI_ACPI_5_0_USE_PLATFORM_CLOCK                     BIT15
#define EFI_ACPI_5_0_S4_RTC_STS_VALID                       BIT16
#define EFI_ACPI_5_0_REMOTE_POWER_ON_CAPABLE                BIT17
#define EFI_ACPI_5_0_FORCE_APIC_CLUSTER_MODEL               BIT18
#define EFI_ACPI_5_0_FORCE_APIC_PHYSICAL_DESTINATION_MODE   BIT19
#define EFI_ACPI_5_0_HW_REDUCED_ACPI                        BIT20
#define EFI_ACPI_5_0_LOW_POWER_S0_IDLE_CAPABLE              BIT21

///
/// BGRT Version
///
#define EFI_ACPI_5_0_BGRT_VERSION         0x01
///
/// BGRT Status
///
#define EFI_ACPI_5_0_BGRT_STATUS_INVALID  0x00
#define EFI_ACPI_5_0_BGRT_STATUS_VALID    0x01
///
/// BGRT Image Type
///
#define EFI_ACPI_5_0_BGRT_IMAGE_TYPE_BMP  0x00

#pragma pack()
