/** @file
*
*  Copyright (c) 2007-2014, Allwinner Technology Co., Ltd. All rights reserved.
*  http://www.allwinnertech.com
*
*  Mike.Tang <tangmanliang@allwinnertech.com>
*  
*  This program and the accompanying materials                          
*  are licensed and made available under the terms and conditions of the BSD License         
*  which accompanies this distribution.  The full text of the license may be found at        
*  http://opensource.org/licenses/bsd-license.php                                            
*
*  THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,                     
*  WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.             
*
**/

// CreatorID=MSFT	CreatorRev=4.0.0
// FileLength=42	FileChkSum=0xff

//
// Use "ACPI0007" in _HID for all application processor cores
// Each processor also requires a unique number (ACPI Unique ID) for use in the MADT (Interrupt Controller) table
//
Device(PRC0)
{
	//
	// Processor 0
	//
	Name(_HID, "ACPI0007")
	Name(_UID, 0x0)		//Must match an entry in the MADT
}
		
Device(PRC1)
{
	//
	// Processor 1
	//
	Name(_HID, "ACPI0007")
	Name(_UID, 0x1)		//Must match an entry in the MADT
}

Device(PRC2)
{
	//
	// Processor 2
	//
	Name(_HID, "ACPI0007")
	Name(_UID, 0x2)		//Must match an entry in the MADT
}

Device(PRC3)
{
	//
	// Processor 3
	//
	Name(_HID, "ACPI0007")
	Name(_UID, 0x3)		//Must match an entry in the MADT
}


Device(PIOB)
{

	Name(_HID, "AWTH0001")		//Causes Windows to load your driver ('GPIO Class Extension Client' driver)
	Name(_CID, "AWTH0001")
	Name(_UID, 1)
	Name(_CRS, ResourceTemplate ()
	{
		//bank register
		MEMORY32FIXED(ReadWrite, 0x01c20824, 0x24, ) 
		//interrupt register
		MEMORY32FIXED(ReadWrite, 0x01c20a00, 0x1c, ) 
		//interrupt number
		Interrupt(ResourceConsumer, Level, ActiveHigh, Shared, , , ) {43}
	})	
		
		Method(IODI, 0, NotSerialized)
		{
			Return (Buffer(0x0f)
			{
			/*BaseAddress:0x01c20800*/0x00, 0x08, 0xc2, 0x01,
			/*Addresslength:*/0x24,0x00,
			/*TotalGroup*/0x01,0x00,
			/*group B */0x0A, 0x01
			})
		}
}// End of Device 

Device(PIOC)
{

	Name(_HID, "AWTH0001")		//Causes Windows to load your driver ('GPIO Class Extension Client' driver)
	Name(_CID, "AWTH0001")
	Name(_UID, 2)
	Name(_CRS, ResourceTemplate ()
	{
		//bank register
		MEMORY32FIXED(ReadWrite, 0x01c20848, 0x24, ) 
	})	
		
		Method(IODI, 0, NotSerialized)
		{
			Return (Buffer(0x0f)
			{
			/*BaseAddress:0x01c20800*/0x00, 0x08, 0xc2, 0x01,
			/*Addresslength:*/0x24,0x00,
			/*TotalGroup*/0x01,0x00,
			/*group C*/0x13, 0x00
			})
		}
}// End of Device 

Device(PIOD)
{

	Name(_HID, "AWTH0001")		//Causes Windows to load your driver ('GPIO Class Extension Client' driver)
	Name(_CID, "AWTH0001")
	Name(_UID, 3)
	Name(_CRS, ResourceTemplate ()
	{
		//bank register
		MEMORY32FIXED(ReadWrite, 0x01c2086c, 0x24, ) 
	})	
		
		Method(IODI, 0, NotSerialized)
		{
			Return (Buffer(0x0f)
			{
			/*BaseAddress:0x01c20800*/0x00, 0x08, 0xc2, 0x01,
			/*Addresslength:*/0x24,0x00,
			/*TotalGroup*/0x01,0x00,
			/*group D*/0x19, 0x00
			})
		}
}// End of Device 

Device(PIOE)
{

	Name(_HID, "AWTH0001")		//Causes Windows to load your driver ('GPIO Class Extension Client' driver)
	Name(_CID, "AWTH0001")
	Name(_UID, 4)
	Name(_CRS, ResourceTemplate ()
	{
		//bank register
		MEMORY32FIXED(ReadWrite, 0x01c20890, 0x24, ) 
	})	
		
		Method(IODI, 0, NotSerialized)
		{
			Return (Buffer(0x0f)
			{
			/*BaseAddress:0x01c20800*/0x00, 0x08, 0xc2, 0x01,
			/*Addresslength:*/0x24,0x00,
			/*TotalGroup*/0x01,0x00,
			/*group E*/0x13, 0x00
			})
		}
}// End of Device 

Device(PIOF)
{

	Name(_HID, "AWTH0001")		//Causes Windows to load your driver ('GPIO Class Extension Client' driver)
	Name(_CID, "AWTH0001")
	Name(_UID, 5)
	Name(_CRS, ResourceTemplate ()
	{
		//bank register
		MEMORY32FIXED(ReadWrite, 0x01c208b4, 0x24, ) 
	})	
		
		Method(IODI, 0, NotSerialized)
		{
			Return (Buffer(0x0f)
			{
			/*BaseAddress:0x01c20800*/0x00, 0x08, 0xc2, 0x01,
			/*Addresslength:*/0x24,0x00,
			/*TotalGroup*/0x01,0x00,
			/*group F*/0x7, 0x00
			})
		}
}// End of Device

Device(PIOG)
{

	Name(_HID, "AWTH0001")		//Causes Windows to load your driver ('GPIO Class Extension Client' driver)
	Name(_CID, "AWTH0001")
	Name(_UID, 6)
	Name(_CRS, ResourceTemplate ()
	{
		//bank register
		MEMORY32FIXED(ReadWrite, 0x01c208D8, 0x24, ) 
		MEMORY32FIXED(ReadWrite, 0x01c20a20, 0x1c, ) 
		Interrupt(ResourceConsumer, Level, ActiveHigh, Shared, , , ) {49}
	})	
		
		Method(IODI, 0, NotSerialized)
		{
			Return (Buffer(0x0f)
			{
			/*BaseAddress:0x01c20800*/0x00, 0x08, 0xc2, 0x01,
			/*Addresslength:*/0x24,0x00,
			/*TotalGroup:0x01*/0x01,0x00,
			/*group G:0x01,1*/0xe, 0x01
			})
		}
}// End of Device

Device(PIOH)
{

	Name(_HID, "AWTH0001")		//Causes Windows to load your driver ('GPIO Class Extension Client' driver)
	Name(_CID, "AWTH0001")
	Name(_UID, 7)
	Name(_CRS, ResourceTemplate ()
	{
		//bank register
		MEMORY32FIXED(ReadWrite, 0x01c208FC, 0x24, ) 
		MEMORY32FIXED(ReadWrite, 0x01c20a40, 0x24, ) 
		Interrupt(ResourceConsumer, Level, ActiveHigh, Shared, , , ) {53}
	})	
		
		Method(IODI, 0, NotSerialized)
		{
			Return (Buffer(0x0f)
			{
			/*BaseAddress:0x01c20800*/0x00, 0x08, 0xc2, 0x01,
			/*Addresslength:*/0x24,0x00,
			/*TotalGroup:0x01*/0x01,0x00,
			/*group H:0x01,1*/0xc, 0x01
			})
		}
}// End of Device


Device(PIOL)
{
	//
	// GPIO controller # 1, e.g. the only GPIO controller IP on the SoC
	//	NOTE: The namespace path to this device ("\\_SB.GPI1") will appear in the GpioIo() or GpioInt()
	//	macros for all peripherals that are connected to pins on this IP (see the TUCH Device example, below)
	//
	Name(_HID, "AWTH0001")		//Causes Windows to load your driver ('GPIO Class Extension Client' driver)
	Name(_CID, "AWTH0001")
	Name(_UID, 0)
	// 
	// The number, type and order of system resources reported in _CRS MUST MATCH requirements of the device driver for the device.
	// For the built-in Windows GPIO Class Extension, _CRS MUST be done in the following format:
	//
	Name(_CRS, ResourceTemplate ()
		{
		//bank0(PL)
		MEMORY32FIXED(ReadWrite, 0x01f02c00, 0x24, ) 
		MEMORY32FIXED(ReadWrite, 0x01f02e00, 0x1c, )
		Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {77}  
	
		})//End of _CRS		
		
		Method(IODI, 0, NotSerialized)
		{
			Return (Buffer(0x0f)
			{
			/*BaseAddress:0x01f02c00*/0x00, 0x2c, 0xf0, 0x01,
			/*Addresslength:*/0x24,0x00,
			/*TotalGroup*/0x01,0x00,
			/*group L*/0x0d, 0x01
			})
		}

}// End of Device 