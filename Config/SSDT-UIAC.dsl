// SSDT-UIAC-ALL.dsl
//
// This SSDT can be used as a template to build your own
// customization for USBInjectAll.kext.
//
// This SSDT contains all ports, so using it is the same as without
// a custom SSDT.  Delete ports that are not connected or ports you
// do not need.
//
// Change the UsbConnector or portType as needed to match your
// actual USB configuration.
//
// Note:
// portType=0 seems to indicate normal external USB2 port (as seen in MacBookPro8,1)
// portType=2 seems to indicate "internal device" (as seen in MacBookPro8,1)
// portType=4 is used by MacBookPro8,3 (reason/purpose unknown)
//

DefinitionBlock ("", "SSDT", 2, "hack", "UIAC-ALL", 0)
{
    Device(_SB.EC)
    {
        Name(_HID, "EC000000")
    }

    Device(_SB.USBX)
    {
        Name(_ADR, 0)
        Method (_DSM, 4)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Return (Package()
            {
                // these values from iMac17,1
                "kUSBSleepPortCurrentLimit", 2100,
                "kUSBSleepPowerSupply", 5100,
                "kUSBWakePortCurrentLimit", 2100,
                "kUSBWakePowerSupply", 5100,
            })
        }
    }

    Device(UIAC)
    {
        Name(_HID, "UIA00000")

        Name(RMCF, Package()
        {
            // USB Power Properties for Sierra (using USBInjectAll injection)
            "AppleBusPowerController", Package()
            {
                // these values happen to be iMac14,2 values...
                "kUSBSleepPortCurrentLimit", 2100,
                "kUSBSleepPowerSupply", 4700,
                "kUSBWakePortCurrentLimit", 2100,
                "kUSBWakePowerSupply", 4700,
            },
            
            // XHC overrides
            "8086_a12f", Package()
            {
                "port-count", Buffer() { 26, 0, 0, 0 },
                "ports", Package()
                {
                    "HS01", Package()  // Back Row 4 Col 1 (USB 3.1 Gen 1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 1, 0, 0, 0 },
                    },
                    "HS02", Package()  // Back Row 4 Col 2 (USB 3.1 Gen 1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 2, 0, 0, 0 },
                    },
                    "HS03", Package()  // Front Right 1 (USB 3.0)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 3, 0, 0, 0 },
                    },
                    "HS04", Package()  // Front Right 2 (USB 3.0)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 4, 0, 0, 0 },
                    },
                    // Disable due to 15 ports limitation
                    //"HS05", Package()  // Back Row 3 Col 1 (USB 3.1 Gen 1)
                    //{
                    //    "UsbConnector", 3,
                    //    "port", Buffer() { 5, 0, 0, 0 },
                    //},
                    "HS06", Package()  // Back Row 3 Col 2 (USB 3.1 Gen 1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 6, 0, 0, 0 },
                    },
                    "HS07", Package()  // Front Left 1 (USB 2.0)
                    {
                        "UsbConnector", 0,
                        "port", Buffer() { 7, 0, 0, 0 },
                    },
                    "HS08", Package()  // Front Left 2 (USB 2.0) -> WIFI/BT Card
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 8, 0, 0, 0 },
                    },
                    // Disable due to 15 ports limitation
                    //"HS09", Package()  // Back Row 2 Col 2 (USB 2.0)
                    //{
                    //    "UsbConnector", 0,
                    //    "port", Buffer() { 9, 0, 0, 0 },
                    //},
                    // Disable due to 15 ports limitation
                    //"HS10", Package()  // Back Row 2 Col 1 (USB 2.0)
                    //{
                    //    "UsbConnector", 0,
                    //    "port", Buffer() { 10, 0, 0, 0 },
                    //},
                    "HS11", Package()  // Back Row 1 Col 1 (USB 2.0)
                    {
                        "UsbConnector", 0,
                        "port", Buffer() { 11, 0, 0, 0 },
                    },
                    "HS12", Package()  // Back Row 1 Col 2 (USB 2.0)
                    {
                        "UsbConnector", 0,
                        "port", Buffer() { 12, 0, 0, 0 },
                    },
                    "SS01", Package()  // Back Row 4 Col 1 (USB 3.1 Gen 1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 17, 0, 0, 0 },
                    },
                    "SS02", Package()  // Back Row 4 Col 2 (USB 3.1 Gen 1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 18, 0, 0, 0 },
                    },
                    "SS03", Package()  // Front Right 1
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 19, 0, 0, 0 },
                    },
                    "SS04", Package()  // Front Right 2
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 20, 0, 0, 0 },
                    },
                    // Disable due to 15 ports limitation
                    //"SS05", Package()  // Back Row 3 Col 1 (USB 3.1 Gen 1)
                    //{
                    //    "UsbConnector", 3,
                    //    "port", Buffer() { 21, 0, 0, 0 },
                    //},
                    "SS06", Package()  // Back Row 3 Col 2 (USB 3.1 Gen 1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 22, 0, 0, 0 },
                    },
                },
            },
        })
    }
}
//EOF
