All vBIOS versions uploaded here are created to use in Apple iMac models, only. No support for any PC laptops here.

Tried to use speaking file names to avoid confusion after downloading multiple files from this and other folders in this repository.
Files containing the EnableGop string use the OpenCore EnableGop driver and will enable backlight on power on and show the EFI boot picker when pressing alt/option on all listed iMac models!

The iMac9.1 limited by an older and different firmware version needed a modified version of the EnableGop driver. I managed to get it working and now we support all ever manufactured Mac desktop systesm with MXM3 slots. The vBIOS versions are labeled as with EnableGop91 as part of the file name. 

Files containing the LVDS string are meant for both LVDS systems: iMac9,1 24" and iMac10,1 21.5" 
All other files are optimized for eDP connected internal displays as found in the iMac10,1 27 inch, all iMac11,x and iMac12,x models.

Some files contain names like Elpida, Samsung, and Hynix (VRAM manufacturing companies). 
Hynix memory comes on two different flavors, AFR and BFR.
It will help you to identify the correct version in case you see multiple similar named vBIOS files.
Some files just contain an ALT name tag (same as above, but it is just an alternative VRAM support version without naming special vendors).
If the normal version causes problems try the ALT version. 

All file names begin with the graphics card marketing name chosen by the vendor, i.e. WX4130 (AMD Radeon Pro WX 4130).

Since not all GPU chips are really identical (binning ) some cards may run with higher VRAM or core clock speed settings. The WX4170 versions are forcing such higher clock speeds. If you experience any form of instability use the slightly lower clocked WX4150 versions, instead. One cannot change the GPU chip characteristics after production.

We usually did not change power, voltage or clock settings to avoid any stability issues. 
But we cannot guarantee you got a card running well with vBIOS versions provided here.

The recent version of the EnableGop driver is V1.3 - I will update all vBIOS files during the next days and in future only provide updates if serious issues will be fixed. So far - as iMacs are concerned - no such issues are known. Each card works well even with the 1.1 release.
