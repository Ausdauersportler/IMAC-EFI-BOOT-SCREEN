# PCI option ROM binary template

little_endian

set image_num 0
set image_offset 0
set has_next_image 1

while {$has_next_image == 1} {
    section "ROM Header $image_num" {
        goto $image_offset
        requires $image_offset "55 AA"
        uint16 -hex "ROM Signature"
        goto [expr $image_offset + 0x18]
        set pci_data_offset [uint16]
        goto [expr $image_offset + $pci_data_offset + 0x14]
        set code_type [uint8]
        goto [expr $image_offset + 2]
        switch $code_type {
            0 {
                # Intel x86/PC compatible
                # Documented in: PCI Firmware Specification, Revision 3.1
                #                Section 5.2.1: PC-compatible Expansion ROMs (Code Type 0)
                #
                # Only within the first header part we find the data and command table offsets
                # goto start of PCIR - at least 6 bytes for PCIR offset (2) data table (2) command table(2)
                set image_size [uint8 "Image Size"]
                set init_entry_point [hex 3 "Init Entry Point"]
                hex 0x12 "Reserved"
            }
            1 {
                # Open Firmware
                # Documented in: PCI Bus Binding to Open Firmware, Revision 2.1
                #                Section 9: ROM Image Format for FCode
                set fcode_program_offset [uint16 -hex "FCode Program Offset"]
                hex 0x14 "Reserved"
            }
            2 {
                # Hewlett-Packard PA RISC
                hex 0x16 "Reserved"
            }
            3 {
                # Extensible Firmware Interface (EFI)
                # Documented in: Unified Extensible Firmware Interface Specification, Version 2.8
                #                Section 14.4.2: PCI Option ROMs, Table 133
                set image_size [uint16 "Image Size"]
                requires [expr $image_offset + 4] "F1 0E"
                uint32 -hex "EFI Signature"
                set efi_subsystem [uint16 -hex "EFI Subsystem"]
                set efi_machine_type [uint16 -hex "EFI Machine Type"]
                set efi_compression_type [uint16 -hex "EFI Compression Type"]
                hex 8 "Reserved"
                set efi_image_offset [uint16 -hex "EFI Image Offset"]
            }
            default {
                hex 0x16 "Reserved"
            }
        }

        set pci_data_offset [uint16 -hex "PCI Data Structure Offset"]
        
        #
        # Ausdauersportler.eu - successfully avoiding desktop jobs since 1964
        #
        switch $code_type {
            0 {
                set counter 6
                goto [expr $image_offset + $pci_data_offset - $counter]
                set pci_data_offset_copy [uint16]
                #  and go back in steps of two bytes until you find the copy of the PCIR offset
                while {$pci_data_offset_copy != $pci_data_offset} {
                    set counter [expr $counter + 2]
                    goto [expr $image_offset + $pci_data_offset - $counter]
                    set pci_data_offset_copy [uint16]
                }
                # the directly following two bytes are the data table offset
                goto [expr $image_offset + $pci_data_offset - $counter + 0x2]
                uint16 -hex "Command Table Offset"
                # the following two bytes are the command table offset
                goto [expr $image_offset + $pci_data_offset - $counter + 0x4]
                uint16 -hex "Data Table Offset"
                # now mark the copy of the PCIR offset
                goto [expr $image_offset + $pci_data_offset - $counter]
                uint16 -hex "Copy PCI Data Structure Offset"
                
                #
                # one could add parsing of the Data and Command tables...
                #
            }
        }
    }

    if {$pci_data_offset != 0} {
        goto [expr $image_offset + $pci_data_offset + 0xC]
        set pci_data_rev [uint8]
        goto [expr $image_offset + $pci_data_offset]
        section "PCI Data Structure $image_num" {
            requires [expr $image_offset + $pci_data_offset] "50 43 49 52" ; # "PCIR"
            ascii 4 "Signature"
            set vendor_id [uint16 -hex "Vendor ID"]
            set device_id [uint16 -hex "Device ID"]
            if {$pci_data_rev == 3} {
                set device_list_offset [uint16 -hex "Device List Offset"]
            } else {
                uint16 -hex "Reserved"
            }
            set pci_data_len [uint16 "PCI Data Structure Length"]
            set pci_data_rev [uint8 "PCI Data Structure Revision"]
            set class_code [hex 3 "Class Code"]
            set image_len [uint16 "Image Length"]
            set vendor_rom_rev [uint16 "Vendor ROM Revision"]
            set code_type [uint8 "Code Type"]
            set last_image_indicator [uint8 -hex "Last Image Indicator"]
            if {$pci_data_rev == 3} {
                set max_runtime_image_len [uint16 "Maximum Runtime Image Length"]
                set config_utility_code_offset [uint16 -hex "Configuration Utility Code Offset"]
                set dmtf_clp_entry_point_offset [uint16 -hex "DMTF CLP Entry Point Offset"]
            } else {
                uint16 -hex "Reserved"
            }

            # Surely there's a better way to do this...?
            set has_next_image [expr $last_image_indicator >> 7]
            set has_next_image [expr ! $has_next_image]
            if {$has_next_image == 1} {
                incr image_offset [expr $image_len * 512]
            }
        }
    }

    if {$pci_data_rev == 3 && $device_list_offset != 0} {
        goto [expr $image_offset + $pci_data_offset + $device_list_offset]
        section "Device List $image_num" {
            set device_id_idx 0
            set supported_device_id(device_id_idx) [uint16]
            while {$supported_device_id(device_id_idx) != 0} {
                move -2
                set supported_device_id(device_id_idx) [uint16 -hex "Supported Device ID ${device_id_idx}"]
                incr device_id_idx
                set supported_device_id(device_id_idx) [uint16]
            }
        }
    }

    incr image_num
}
