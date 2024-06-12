# IMAC-EFI-BOOT-SCREEN

How to create an EFI boot screen vBIOS for Apple 2009 to Mid 2011 iMac systems using AMD MXM3 graphics cards

My goal is to provide a comprehensive guide how to construct EFI BIOS versions for some AMD MXM cards. As described in detail in this [thread](https://forums.macrumors.com/threads/2011-imac-graphics-card-upgrade.1596614/post-17425857) owners of modular Apple iMac models built in 2009-2011 with MXM slot graphcs card can replace the original ATI card either with an Nvidia Kepler or an AMD GCN 1.0 to 4.0 card. While there has been a lot of success offering an EFI boot screen with NVIDIA cards development stuck with the AMD cards at some point where an iMac firmware modification has been proposed. Although the firmware modification is quite simple the adoption rate is frankly speaking zero. IMHO this is still the best way to go. Nevertheless even this method will need a BIOS constructed in the same way as described here within the wiki. 

Just to complete this introduction: 
Lately [improvements](https://forums.macrumors.com/threads/imac-2011-maxwell-and-pascal-gpu-upgrade.2300989/post-30017630) have been made to add a NVIDIA Maxwell and Pascal card, but please note there are no macOS drivers available within any macOS versions starting with Mojave, and there is limited EFI boot screen support.

The [wiki](https://github.com/Ausdauersportler/IMAC-EFI-BOOT-SCREEN/wiki) decribes tools, sources, methods, orignal limitations, solutions and state of the current development.  

## iMac models supported

This repository is limited to these eight iMac models published from 2009 to 2011:

- iMac9,1 Early 2009 A1225 24 inch (LVDS) (using a modified EnableGop9,1 driver, see note 1)
- iMac10,1 Late 2009 A1311 21.5 inch (LVDS) (see note 2)

- iMac10,1 Late 2009 A1312 27 inch (eDP, see note 3 about EG2)

- iMac11,1 Late 2009 A1312 27 inch (eDP)
- iMac11,2 Mid 2010 A1311 21.5 inch (eDP)
- iMac11,3 Mid 2010 A1312 27 inch (eDP)

- iMac12,1 Mid 2011 A1311 21.5 inch (eDP)
- iMac12,2 Mid 2011 A1312 27 inch (eDP)

Notes: 

1. Finally it was possible to include the iMac9,1 Mid 2009 A1225 24 inch to this list. The [2.93 GHz](https://everymac.com/systems/apple/imac/specs/imac-core-2-duo-3.06-24-inch-aluminum-early-2009-specs.html) and [3.06 GHz](https://everymac.com/systems/apple/imac/specs/imac-core-2-duo-2.93-24-inch-aluminum-early-2009-specs.html) versions were equipped with MXM3 slots and non metal graphics cards (GT120, GT130, AMD 4850). Best cards to use are the AMD FirePro M4000, M5100, W5170M, and M6000. The power hungry Saturn cards M6100 and W6170M/W6150M will over heat the system under load rapidly. This system needs a special EnableGop91 driver. All vBIOS files are marked aka named like this and include the LVDS string, too. Some more recent NVIDIA MXM3 cards may still have LVDS signaling support and therfore may work with these iMac9,1 system, too (never tested).

2. vBIOS file names contain the string LVDS, but not show the EnableGop91 string (see note 1). Unfortunately all more recent AMD GPUS starting the the Polaris/GCN4 architecture lack LVDS signaling hardware support. Therefore you cannot get those cards to display the boot screen unless you connect the internal display using a third party display driver board the external DP port - making it an externally connected display.

3. EG2 versions of vBIOS do not run on iMac10,1 A1312 systems, you get only a white screen in power on/boot. EG versions support all types of Macs listed.

4. Althout one cannot modify the legacy part of the vBIOS it is possible to inject a modified legacy vBIOS (the first 64K of it) using an SSDT or OpenCore DeviceProperties (ATY,bin_image) to enable the backlight control on Big Sur and Monterey. This mod does not apply or work with any Windows installation. Adding the EnableGop driver brought back EFI boot screen support. First and only replacement card which enables both external display connectors on iMac12,2. 

## AMD graphcis cards supported

Currently we have tested these cards and can confirm the method works with:

- AMD FirePro M4000
- AMD FirePro M5100
- AMD FirePro M6000
- AMD FirePro W5170M

- AMD FirePro M6100
- AMD FirePro W6150M
- AMD FirePro W6170M

- AMD FirePro W7170M 
- AMD FirePro S7100X

- AMD Radeon Pro WX4130 mobile
- AMD Radeon Pro WX4150 mobile
- AMD Radeon Pro WX4170 mobile

- AMD Radeon Pro WX3200 mobile

- AMD Radeon Pro RX470 mobile
- AMD Radeon Pro RX480 mobile
- AMD Radeon Pro WX7100 mobile

- AMD Radeon Pro RX5500XT mobile (see note 4 above)

## Credits

Most knowledge has been gathered by me from contributions made by [Nick [D]vB](https://forums.macrumors.com/members/nick-d-vb.1132239/), [nikey22](https://forums.macrumors.com/members/nikey22.1199855/), and [internetzel](https://forums.macrumors.com/members/internetzel.959462/) who spent some nights to explain everything in detail to me and who has much more patience to dive deeply into this matter than I do. Hope he will join me to fill this repository with contents. Last but not least thanks to [dfranetic](https://github.com/franetic), he finished what I could not have done. Great team!

Thanks to [rthpjm](https://forums.macrumors.com/members/rthpjm.535915/) for finding a W6150M and the necessary legacy vBIOS in some HP firmware update. Special thanks to [edwardgeo](https://forums.macrumors.com/members/edwardgeo.1274066/) for countless ideas and incredible knowledge about indepth AMD vBIOS modifications. All the best if these dark times!

[m0bil](https://forums.macrumors.com/members/m0bil.1235134/) has become the expert for all NVIDIA modifications and probably he should start a similar repository about it and more importantly to this project he is the undisputed master of all iMac firmware modifications.

Finally many thanks to [Mike Beaton](https://github.com/mikebeaton) who developed an EFI driver named [EnableGop](https://github.com/mikebeaton/OpenCorePkg/tree/master/Staging/EnableGop) usable for both MacPro5,1 and modular iMacs as listed above using either Nvidia or AMD graphics cards to enable the EFI boot picker. I had to modify this driver a little bit to make it work on the older (LVDS) iMac9,1 model. This change has not been included into the EnableGop source tree and you need to get the driver named EnableGop91 compiled from this page. It works as desigend, with AMD and likely with NVIDIA cards as well.

## Support

If you want to support the AMD (i)Mac vBIOS development or just buy me a coffee [donations](https://www.paypal.com/paypalme/Ausdauersportler) are greatly appreciated.

