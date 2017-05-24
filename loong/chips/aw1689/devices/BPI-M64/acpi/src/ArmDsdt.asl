/** @file
*
*  Copyright (c) 2007-2014, Allwinner Technology Co., Ltd. All rights reserved.
*  http://www.allwinnertech.com
*
*  Martin.Zheng <martinzheng@allwinnertech.com>
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

DefinitionBlock("mindsdt.aml", "DSDT", 0x01, "AWTH", "SUN50IW1", 0x00000001)
{
    Scope(_SB_)
    {
        Include("../../../default/acpi/soc_common.asl")

        Method (UCRS, 4, NotSerialized)
        {
            Name (RSRC, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00000000,         // Address Length
                    Y002)
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, Y003)
                {
                    0x00000000,
                }
            })
            CreateDWordField (RSRC, \_SB.UCRS.Y002._BAS, MBAS)  // _BAS: Base Address
            CreateDWordField (RSRC, \_SB.UCRS.Y002._LEN, MBLE)  // _LEN: Length
            CreateWordField (RSRC, \_SB.UCRS.Y003._INT, INTN)  // _INT: Interrupts
            CreateField (RSRC, \_SB.UCRS.Y003._SHR, 0x02, SHRN)  // _SHR: Sharable
            Store (Arg0, MBAS)
            Store (Arg1, MBLE)
            Store (Arg2, INTN)
            Store (Arg3, SHRN)
            Return (RSRC)
        }
                
        Device (USB1)  //USB1
        {    
            Name ( _ADR, 0x01c1b000)  // _ADR: Address
            Name (_CID, "ACPI\\PNP0D20")  // _CID: Compatible ID
            Name (_HRV, 0x00)  // _HRV: Hardware Revision
            Name (_UID, One)  // _UID: Unique ID
            Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
            {
                Return ("PNP0D20")
            }
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Store (0x01c1b000, Local0)
                Store (0x400, Local1)
                Return (UCRS (Local0, Local1, 106, 0x03))
            }
        } // Device( USB1)
        
		
		Device(I2C0)
		{
			Name(_HID, "AWTH0002")								
			Name(_UID, 0x0)					
			Name(_CRS, ResourceTemplate ()
				{
					MEMORY32FIXED(ReadWrite, 0x01c2ac00, 0x3ff,	) 
					Interrupt(ResourceConsumer, Edge, ActiveLow, Exclusive, , , ) {38}
				})
				
			Method(BNUM, 0, NotSerialized)
			{
				Return (Buffer(0x2)
				{
					0x0,0x4
				})				
			}
		}//End of Device 'i2c0'
		
		Device(I2C1)
		{
			Name(_HID, "AWTH0002")								
			Name(_UID, 0x1)					
			Method (_STA, 0, NotSerialized) 
            {
                Return (0x0F)
            }
			Name(_CRS, ResourceTemplate ()
			{
				MEMORY32FIXED(ReadWrite, 0x01c2b000, 0x3ff, ) 
				Interrupt(ResourceConsumer, Edge, ActiveLow, Exclusive, , , ) {39}
            })
				
			Method(BNUM, 0, NotSerialized)
			{
				Return (Buffer(0x2)
				{
					0x1,0x2
				})				
			}
			
		}//End of Device 'i2c1'
		
		Device(I2C2)
		{
			Name(_HID, "AWTH0002")								
			Name(_UID, 0x2)					
		    Method (_STA, 0, NotSerialized) 
            {
                Return (0x00)
            }
			Name(_CRS, ResourceTemplate ()
			{
				MEMORY32FIXED(ReadWrite, 0x01c2b400, 0x3ff, ) 
				Interrupt(ResourceConsumer, Edge, ActiveLow, Exclusive, , , ) {40}
			})
				
			Method(BNUM, 0, NotSerialized)
			{
				Return (Buffer(0x2)
				{
					0x2,0x2
				})				
			}
			

		}//End of Device 'i2c2'
		

        Device(SDM0)
        {
            Name(_HID, "AWTH0005")                                
            Name(_UID, 0x0)              
            Method (_STA, 0, NotSerialized) 
            {
                Return (0x0F)
            }      
            Name(_CRS, ResourceTemplate ()
            {
                MEMORY32FIXED(ReadWrite, 0x01c0F000, 0x1000, ) 
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {92}
            })
            
            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
            {
                Return (Zero)
            }
        
        }//End of Device 'SDM0'
		
		Device(SDM1)
        {
            Name(_HID, "AWTH0005")    
            Name(_UID, 0x1)      		
            Method (_STA, 0, NotSerialized) 
            {
                Return (0x0F)
            }              
            Name(_CRS, ResourceTemplate ()
            {
                MEMORY32FIXED(ReadWrite, 0x01c10000, 0x1000, ) 
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {93}
            })
            
            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
            {
                Return (Zero)
            }
			
			Device (WLAN)
            {
                Name (_S4W, 0x02)
                Name (_S0W, 0x02)
                // Name (_ADR, One)  // _ADR: Address
                // Method (_STA, 0, NotSerialized)  // _STA: Status
                // {
                    // Return (0x0F)
                // }
        
                // Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                // {
                    // Return (Zero)
                // }
        
                // Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                // {
                    // Name (RBUF, ResourceTemplate ()
                    // {
                        // GpioInt(Edge, ActiveHigh, ExclusiveAndWake, PullDown, 0, "\\_SB.PIOL") {3}
                        // GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly, "\\_SB.PIOL", 0x00, ResourceConsumer, ,) { 2 }
                    // })
                    // Return (RBUF)
                // }
				
				Method (_ADR)
				{
					Return (0)
				}

				Method (_RMV) // Is removable
				{
					Return (0) // 0 - fixed
				}
            }
              
        }//End of Device 'SDM1'
		

        Device(SDM2)
        {
            Name(_HID, "AWTH0005")                                
            Name(_UID, 0x2)     
            Method (_STA, 0, NotSerialized) 
            {
                Return (0x0F)
            }                  
            Name(_CRS, ResourceTemplate ()
            {
                MEMORY32FIXED(ReadWrite, 0x01c11000, 0x1000, ) 
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {94}
            })
            
            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
            {
                Return (Zero)
            }
        
        }//End of Device 'SDM2'
        
        Device(ETH0)
        {
            Name(_HID, "AWTH0015")                                
            Name(_UID, 0x0)              
            Method (_STA, 0, NotSerialized) 
            {
                Return (0x0F)
            }      
            Name(_CRS, ResourceTemplate ()
            {
                MEMORY32FIXED(ReadWrite, 0x01c30000, 0x10000, ) 
                MEMORY32FIXED(ReadWrite, 0x01c20874, 0x4,)
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {114}
            })
            
            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
            {
                Return (Zero)
            }
        
        }//End of Device 'ETH0'
		
        Device(VI2S)
	    {
	 	    Name(_HID, "AWTH0006")
            Name(_UID, 0x1)
            Name(_CRS, ResourceTemplate ()
            {                  
                FixedDMA(0, 0, Width16Bit) // DMA chnnel 0 requstline 0 as VI2S Tx here
                FixedDMA(1, 1, Width16Bit) // DMA chnnel 1 requstline 0 as VI2S Rx here
            })

	    }	// End of Device "VI2S"
				
     
        Device(CODC)
        {
	 	  	Name(_HID, "AWTH0007")
	 	  	Name(_CRS, ResourceTemplate ()
	 	  	{
	 	  		MEMORY32FIXED(ReadWrite, 0x01c22c00, 0x800, )  //codec digital register
	 	  		MEMORY32FIXED(ReadWrite, 0x01f015c0, 0x4, )  //codec analog shadow register
	 	  		MEMORY32FIXED(ReadWrite, 0x01c20000, 0x400, )  //ccmu register to control clock
	 	  		Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {61} //audio codec interrupt 
	 	  		Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {60} //earphone detection	
	 	  	})
        }	// End of Device "CODC"
				
        Device(AUDO)
        {
		    Name(_HID, "AWTH0008")
			Name(_UID, 0x1)                           
			Name (_DEP, Package(0x2)
			{
                \_SB_.CODC,
                \_SB_.VI2S
			})            
        }

        Device(CIRR)
        {
            Name(_HID, "AWTH0213")
            Name(_UID, 0x1)
			Method (_STA, 0, NotSerialized)
			{
				Return (0x0F)
			}
			
			Name (_CRS, ResourceTemplate ()
            {
				MEMORY32FIXED(ReadWrite, 0x01F02000, 0x54,)
				Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , ,) {69}
			})
			
			Method (_RMV, 0, NotSerialized)
			{
				Return (Zero)
			}
        }
 

		  
        Device(RHPX)
        {
            Name(_HID, "MSFT8000")
            Name(_CID, "MSFT8000")
            Name(_UID, 1)

            Name(_CRS, ResourceTemplate()
            {
//Index 1
                I2CSerialBus(              // 
                    0x3F,                // SlaveAddress: placeholder
                    ,                      // SlaveMode: default to ControllerInitiated
                    400000,                     // ConnectionSpeed: placeholder
                    ,                      // Addressing Mode: default to 7 bit
                    "\\_SB.I2C1",          // ResourceSource: I2C bus controller name
                    ,
                    ,
                    ,                      // Descriptor Name: creates name for offset of resource descriptor
                    )                      // VendorData
// Index 2
                I2CSerialBus(              // 
                    0x3C,                // SlaveAddress: placeholder
                    ,                      // SlaveMode: default to ControllerInitiated
                    400000,                     // ConnectionSpeed: placeholder
                    ,                      // Addressing Mode: default to 7 bit
                    "\\_SB.I2C1",          // ResourceSource: I2C bus controller name
                    ,
                    ,
                    ,                      // Descriptor Name: creates name for offset of resource descriptor
                    )                      // VendorData
// Index 3
                I2CSerialBus(              // 
                    0x08,                // SlaveAddress: placeholder
                    ,                      // SlaveMode: default to ControllerInitiated
                    400000,                     // ConnectionSpeed: placeholder
                    ,                      // Addressing Mode: default to 7 bit
                    "\\_SB.I2C1",          // ResourceSource: I2C bus controller name
                    ,
                    ,
                    ,                      // Descriptor Name: creates name for offset of resource descriptor
                    )                      // VendorData  	
					
					
					GpioIO(Shared, PullUp, 0, 0, IoRestrictionNone, "\\_SB.PIOC", 0, ResourceConsumer, , ) { 0 }
					GpioInt(Edge, ActiveBoth, Shared, PullUp, 0, "\\_SB.PIOC",)                            { 0 }
					GpioIO(Shared, PullUp, 0, 0, IoRestrictionNone, "\\_SB.PIOC", 0, ResourceConsumer, , ) { 2 }
					GpioInt(Edge, ActiveBoth, Shared, PullUp, 0, "\\_SB.PIOC",)                            { 2 }
					GpioIO(Shared, PullUp, 0, 0, IoRestrictionNone, "\\_SB.PIOC", 0, ResourceConsumer, , ) { 3 }
					GpioInt(Edge, ActiveBoth, Shared, PullUp, 0, "\\_SB.PIOC",)                            { 3 }
					
					GpioIO(Shared, PullUp, 0, 0, IoRestrictionNone, "\\_SB.PIOC", 0, ResourceConsumer, , ) { 4 }
					GpioInt(Edge, ActiveBoth, Shared, PullUp, 0, "\\_SB.PIOC",)                            { 4 }
					GpioIO(Shared, PullUp, 0, 0, IoRestrictionNone, "\\_SB.PIOC", 0, ResourceConsumer, , ) { 7 }
					GpioInt(Edge, ActiveBoth, Shared, PullUp, 0, "\\_SB.PIOC",)                            { 7 }
            })

            Name(_DSD, Package()
            {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package()
                {
                    // I2C1
                    Package(2) { "bus-I2C-I2C1", Package() { 0 }},
                    Package(2) { "bus-I2C-I2C2", Package() { 1 }},
		            Package(2) { "bus-I2C-I2C3", Package() { 2 }},

			        Package(2){"GPIO-PinCount",54},
			        Package(2){"GPIO-UseDescriptorPinNumbers",1},
			        Package(2){"GPIO-SupportedDriveModes",0xf}

                }
            })
        }
				
   }//Scope(_SB_)
}
