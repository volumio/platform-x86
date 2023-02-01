
## **platform-x86**

All references to Volumio 2/ Kernel 3.18.25 have been removed

### **Tracking from buster 08.10.2019**

<sub>

|Date|Author|Change
|---|---|---|
|20191018|gkkpch|Bumped kernel version to 4.19.79
|20191125|gkkpch|Bumped kernel version to 5.4.0
|20200123|gkkpch|Bumped kernel version to 5.4.13 + firmware updates
|20200210|gkkpch|Bumped kernel version to 5.4.18
|20200219|gkkpch|Reverting to kernel version 4.19.104 because of boot issues with 5.4.y
|20200224|gkkpch|Bumping to 4.19.106
|||adding a patch for intel 3138 wifi (https://patchwork.kernel.org/patch/11353871/ )
|20200604|gkkpch|Bumped to 4.19.126
|20201223|gkkpch|Bumped to 4.19.126 (i386 + amd64)
|20201224|gkkpch|Updated to firmware_20201218 (kernel.org)
|||simplified grub.cfg
|20201229|gkkpch|Bumped to 4.19.164 and 5.10.4 (i386 + amd64)
|20210105|gkkpch|Updated kernel configuration/ corrections for 5.10.4-i386
|20210115|gkkpch|Updated intel hda soundcards tweaks
|20210119|gkkpch|Updated intel hda soundcards tweaks
|||improved AMD support
|||grub.cfg cosmetics
|20210122|gkkpch|Bumped to kernel 5.10.9
|||Removed a load of irrelevant modules from kernel config
|20210209|gkkpch|(grub.cfg) Removed kernel version from image name (fixed 'vmlinuz')
|20210216|gkkpch|Bumped to kernel 5.10.16, added RTL8821CE/8822CE
|20210217|gkkpch|Bumped to kernel 5.10.17 (i386/amd64) for beta testing
|20210226|gkkpch|Alsa UCM: modified bytcr-init.sh
|20210227|gkkpch|Alsa UCM: modified bytcr-init.sh/ bytcht-es8316 additions
|20210305|gkkpch|Bumped to 5.10.20 x86_amd64
|||removed i386 (for the beta, may add later)
|20210308|gkkpch|On request: added VIRTIO_NET and VIRTIO_BLK drivers
|20210409|gkkpch|Bumped to 5.10.28/ cherrytrail init update (es8316)
|20210412|gkkpch|Optimized x5-z8350 machines with rt5640 codec
|||Auto jack detection for switching output
|20210508|gkkpch|Bumped to 5.10.35
|20210821|gkkpch|Bumped to 5.10.60
|20210915|gkkpch|Bumped to 5.10.68
|20211006|gkkpch|Bumped to 5.10.70
|20211012|gkkpch|Added Z83-II specific "brcmfmac43455-sdio.AZW-Z83 II.txt" to broadcom nvram
|20211019|gkkpch|Completed soundcard "HD-Generic Audio" profile
|20211026|gkkpch|Support for audio: cht-bsw-rt5672 + C-Media
|||improved jack detection (bytcr/cht)
|||new AMD firmware
|||Bumped to kernel 5.10.79
|20211224|gkkpch|Bumped to 5.10.88
|||added Broadcom Tigon Ethernet PHY support
|20220115|gkkpch|Bumped to 5.10.91
|||added Realtek RTL88x2BU wireless support
|20220116|gkkpch|Bumped to 5.10.92
|||added Realtek drivers RTL8723DU/RTL8811CU/RTL88XXAU
|20220131|gkkpch|Bumped to 5.10.95
|||fixed RTL8812AU/RTL8814AU/RTL8821AU wireless driver
|20220404|gkkpch|Bumped to 5.10.109
|||added patch for Cambridge USB Audio devices
|20220420|gkkpch|Bumped to 5.10.112
|||enabled Intel i225-lm/ i225-v ethernet controllers
|20220830|gkkpch|Bumped to 5.10.139
|20230131|gkkpch|Bumped to 5.10.165
|||added support for additional DSD capable devices (see 6.

### **Moving to kernel 6.1.y**


|Date|Author|Change
|---|---|---|
|||Build for 5.10.139 frozen, no more updates.
|20230103|gkkpch|Added kernel 6.1.2
|20230104|gkkpch|Merged linux-firmware-20211027 (for kernel 5.10)
|||firmware-b43, firmware-brcm-sdio-nvram and firmware-cfg80211 into a single firmware tarball ```firmware-20211127.tar.xz```
|||Merged linux-firmware-20221216 (for kernel 6.1)
|||firmware-b43, firmware-brcm-sdio-nvram and firmware-cfg80211 into a single firmware tarball ```firmware-20221216.tar.xz```
|||Bumped to kernel 6.1.3
|20230110|gkkpch|Kernel config: added CONFIG_I2C_HID_ACPI=m 
|||Bumped to kernel 6.1.4
|20230114|gkkpch|Bumped to kernel 6.1.6
|20230130|gkkpch|Bumped to 6.1.8, add direct DSD support: TempoTec Sonata BHD & E1DA #9038D
  









