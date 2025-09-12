EFI compatible vBIOS versions based on Apples own EG2 driver (extracted from different MacBookPro and iMac firmware).
Most native experience when using these EG2 versions, no glitches and no display sync problems. 
Needs an iMac firmware modification as described in the wiki. An alternative solutions is deleting the VGA driver from the legacy part to gain some space needed to add both the CoreEG2 and EDIDParser modules.

Optimal choice for macOS only systems.

UEFI Windows support only with AMD GOP injection via OCLP. 
