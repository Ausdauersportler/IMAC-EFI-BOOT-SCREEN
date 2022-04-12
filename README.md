# IMAC-EFI-BOOT-SCREEN

How to create an EFI boot screen vBIOS for Apple Late 2009 to Mid 2011 iMac systems using AMD MXM graphics cards

Following the guide of this [thread](https://forums.macrumors.com/threads/2011-imac-graphics-card-upgrade.1596614/post-17425857) owners of Apple iMac models built in 2009-2011 with MXM slot graphics cards can replace the original ATI card either with Nvidia Kepler or AMD GCN 1.0 to 4.0 cards. While there has been a lot of success offering an EFI boot screen with NVIDIA cards development stuck with the AMD cards at some point where an iMac firmware modifications has been proposed. IMHO this is still the best way to go.

This repository decribes tools, sources, methods, and limitations of the current development. 

## iMac models supported

This repository is limited to this six iMac models published from 2009 to 2011:

- iMac10,1 Late 2009 A1312 27 inch

- iMac11,1 Late 2009 A1312 27 inch
- iMac11,2 Mid 2010 A1311 21.5 inch
- iMac11,3 Mid 2010 A1312 27 inch

- iMac12,1 Mid 2011 A1311 21.5 inch
- iMac12,2 Mid 2011 A1312 27 inch

Note: It might be possible to inlcude the iMac9,1 Mid 2009 A1225 24 inch and iMac10,1 Mid 2009 A3111 21,5 inch model to this list. Both systems were equipped with MXM slots and MXM graphics cards. But I never had the chance to work with these two older models.

## AMD graphcis cards supported

Currently we have tested these cards and can confirm the method works:

- AMD FirePro M5100
- AMD FirePro M6000
- AMD FirePro W5170M

- AMD FirePro M6100
- AMD FirePro W6170M
- AMD FirePro W7170M 
- AMD FirePro S7100X

- AMD Radeon Pro WX 4130 mobile
- AMD Radeon Pro WX 4150 mobile
- AMD Radeon Pro WX 4170 mobile

- AMD Radeon Pro RX 480 mobile
- AMD Radeon Pro WX 7100 / RX 580 mobile

## Limitations

This method is limited to graphics cards used in Apple systems because it reuses not only drivers on macOS level but also EFI programmes found within the firmware. One can get those firmware parts from updates included in macOS updates or by dumping the firmware from more recent Mac systems. Unfortunatley these three parts need more space than the GOP driver found in most modern AMD vBIOS versions.

The usable address space for all AMD vBIOS modifications is limited (to my knowledge) to the first 128k when to be used in the iMacs listed above. So we were not able to simply replace the GOP with the EFI parts. We had to cut out unused parts from the vBIOS, which is the VGA driver. So we sacreficed Windows accerelated mode in order to gain an EFI boot picker for macOS only systems. You can still use windows in VESA mode for most applications using this vBIOS versions including the tools listed below. 

Currently we are no able to change the output of the EFI boot picker. Some versions offer an invisble boot picker, some only on an external display connected via display port and a few on the internal main LCD. All these vBIOS versions either need a miniDisplay emulator plug or an external display just connected.

## Tools and sources

1. [ATOMTableResize](https://www.overclock.net/threads/gui-tool-atomtableresize.1686521/)
Exchange and modify ATOM objects easily, automatically fixing the checksum upon saving - can be used together with "Hex Fiend" by adding the correct path in the file "editor.ini"
2. [Hex Fiend](https://hexfiend.com/), together with PCI option ROM [template](https://gist.github.com/al3xtjames/b58f22f12bd4952e08c9f30195cc8de6)
3. [EfiRom](https://github.com/tianocore/edk2) from EDK2
EfiRom (BaseTools/Source/C/EfiRom) can be compiled for macOS relatively easy.
Combines compressed EFI drivers and legacy VBIOS part into a VBIOS image ready for flashing
4. [AtomDis](https://www.phoronix.com/scan.php?page=article&item=amd_atombios_dumper&num=1)
For checking the ATOM pointer tables after manually moving/modifying them, compiled executable attached,
header file atombios.h contains valuable information about the structure of most ATOM objects
5. [netkas thread](http://forum.netkas.org/index.php/topic,10827.0.html)
about how to modify port mapping in assembly code
6. [radeon_bios_decode and redsock_bios_decoder](https://github.com/JogleLew/amd-framebuffer-utility/blob/master/AMDFramebufferUtility/)
7. [radeon_bios_decode with hotplug id output](https://www.tonymacx86.com/threads/radeon-compatibility-guide-ati-amd-graphics-cards.171291/)
get information about port mappings in a VBIOS file
8. [Red BIOS Editor](https://www.igorslab.de/en/red-bios-editor-and-morepowertool-adjust-and-optimize-your-vbios-and-even-more-stable-overclocking-navi-unlimited/3/)
tune clock settings (transferring the PowerPlayInfo to a VIBOS accepted by RBE, editing it and finally transfer the edited PowerPlayInfo back to the target VBIOS),
can be used in macOS by means of wine
9. [Polaris BIOS Editor](http://polaris-bios-editor.eu/)
mainly helpful for quickly inspecting the VRAM_Info ATOM object and for correcting the checksum after manual modifications,
doesn't run in wine, so Windows only
10. [UEFIRomExtract](https://github.com/andyvand/UEFIRomExtract)
can be used to extract and decompress GOP or CoreEG2 EFI drivers from a VBIOS file

## Credits

Most knowledge has been gathered by me from contributions made by [Nick [D]vB](https://forums.macrumors.com/members/nick-d-vb.1132239/), [nikey22](https://forums.macrumors.com/members/nikey22.1199855/), and [internetzel](https://forums.macrumors.com/members/internetzel.959462/) who spent some nights to explain everything in detail to me and who has much more patience to dive deeply into this matter than I do. Hope he will join me to fill this repository with contents. 
