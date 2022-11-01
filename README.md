# IMAC-EFI-BOOT-SCREEN

How to create an EFI boot screen vBIOS for Apple Late 2009 to Mid 2011 iMac systems using AMD MXM graphics cards

My goal is to provide a comprehensive guide how to construct EFI BIOS versions for some AMD MXM cards. As described in detail in this [thread](https://forums.macrumors.com/threads/2011-imac-graphics-card-upgrade.1596614/post-17425857) owners of modular Apple iMac models built in 2009-2011 with MXM slot graphcs card can replace the original ATI card either with an Nvidia Kepler or an AMD GCN 1.0 to 4.0 card. While there has been a lot of success offering an EFI boot screen with NVIDIA cards development stuck with the AMD cards at some point where an iMac firmware modification has been proposed. Although the firmware modification is quite simple the adoption rate is frankly speaking zero. IMHO this is still the best way to go. Nevertheless even this method will need a BIOS constructed in the same way as described here within the wiki. 

Just to complete this introduction: Lately [improvements](https://forums.macrumors.com/threads/imac-2011-maxwell-and-pascal-gpu-upgrade.2300989/post-30017630) have been made to add a NVIDIA Maxwell and Pascal card, but please note there are no macOS drivers available within any macOS versions starting with Mojave, and there is no EFI boot screen support.

The [wiki](https://github.com/Ausdauersportler/IMAC-EFI-BOOT-SCREEN/wiki) decribes tools, sources, methods, orignal limitations, solutions and state of the current development.  

## iMac models supported

This repository is limited to these six iMac models published from 2009 to 2011:

- (iMac10,1 Late 2009 A1312 27 inch)

- iMac11,1 Late 2009 A1312 27 inch
- iMac11,2 Mid 2010 A1311 21.5 inch
- iMac11,3 Mid 2010 A1312 27 inch

- iMac12,1 Mid 2011 A1311 21.5 inch
- iMac12,2 Mid 2011 A1312 27 inch

Note: 
It might be possible to inlcude the iMac9,1 Mid 2009 A1225 24 inch and iMac10,1 Mid 2009 A3111 21,5 inch model to this list. Both systems were equipped with MXM slots and MXM graphics cards. But I never had the chance to work with these two older models.

## AMD graphcis cards supported

Currently we have tested these cards and can confirm the method works:

- AMD FirePro M4000
- AMD FirePro M5100
- AMD FirePro M6000
- AMD FirePro W5170M

- AMD FirePro M6100
- (AMD FirePro W6150M)
- AMD FirePro W6170M
- AMD FirePro W7170M 
- AMD FirePro S7100X

- AMD Radeon Pro WX4130 mobile
- AMD Radeon Pro WX4150 mobile
- AMD Radeon Pro WX4170 mobile

- AMD Radeon Pro RX470 mobile
- AMD Radeon Pro RX480 mobile
- AMD Radeon Pro WX7100 mobile

## Credits

Most knowledge has been gathered by me from contributions made by [Nick [D]vB](https://forums.macrumors.com/members/nick-d-vb.1132239/), [nikey22](https://forums.macrumors.com/members/nikey22.1199855/), and [internetzel](https://forums.macrumors.com/members/internetzel.959462/) who spent some nights to explain everything in detail to me and who has much more patience to dive deeply into this matter than I do. Hope he will join me to fill this repository with contents. Last but not least thanks to [dfranetic](https://github.com/franetic), he finshed what I could not have done. Great team!
