
## platform-x86

Kernel Sources: http://www.kernel.org, Version 3.18.25

This repo contains all platform-specific files, used by the Volumio Builder
to create an **X86** image:

- Kernel files (kernel, modules, firmware)
- Other files, e.g. used during the boot process

#### 15.01.2016/gkkpch

This is how VolumioOS kernel 3.18.25 was built
- Download the 3.18.25 kernel source from www.kernel.org (I used wget)

wget https://cdn.kernel.org/pub/linux/kernel/v3.x/linux-3.18.25.tar.xz
unzx linux-3.18.25.tar.xz
tar xvf linux-3.18.25.tar
cd linux-3.18.25

- I used the kernel config from the debian 8.1 distro as a good start.

cp /boot/config-3.16.0-4-amd64 .config
make menuconfig

- make sure 64-bit support is NOT selected (it will be if the host is am amd64)!!
- de-selecting it changes .config to use i386_defconfig
- select overlayfs as a module

make deb-pkg

- You will be asked here what to do with all the new config params (compared to 3.16.0), see saved i386-volumio.config
- I only added some of the drivers that looked interesting
- When finished, you will find the .deb packages in ../
- backup .config i386-volumio_defconfig

#### 21.01.2016/gkkpch

- add to 'make menuconfig':
- ensure Networking >> Networking options >> Network packet filtering >> Core Netfilter Configuration >> Netfilter Xtables support (required for ip_tables) is selected (not as loadable module) and select the all following options as modules.
- ensure Networking >> Networking options >> Network packet filtering >> IP: Net Filter configurationS >> IP Tables support is selected as modules, also for IPv6
- backup .config to i386-volumio.config

#### Update 12.05.2016/gkkpch

- add to 'make menuconfig':
- select ATA as embedded
- select AHCI as embedded
- backup .config to i386-volumio.config

#### Update 20.10.2016/ gkkpch

- re-compiled on a real i386 OS to avoid linux header problems, preventing to compile drivers
- included the tarred Intel driver source for e1000e version 3.3.4
- compiled the e1000e driver and added the module to folder Intel e1000e 3.3.4-NAPI/
(The x86 build process will copy this one over the old intel e1000e driver)

#### Update 10.02.2017/ gkkpch
- re-compiled with module hid-penmount (CONFIG_HID_PENMOUNT=y)
- backup .config to i386-volumio.config

#### Experimental Update 20.07.2017/ gkkpch
- compiled Kernel Version 4.9.29, please put a file .next into the packages folder to build experimental

#### Update 09.09.2017/ gkkpch

- Fixing pops with DSD files, manually patched /sound/usb/endpoint.c with the contents of this patch:
https://github.com/Fourdee/linux/commit/70a8155a64fc3fde57f69f91da3b2835823e0061

#### Experimental Update 12.02.2018/ gkkpch

- Bump to 4.9.80
- Fixing pops with DSD files, manually patched /sound/usb/endpoint.c with the contents of this patch:
  https://github.com/Fourdee/linux/commit/70a8155a64fc3fde57f69f91da3b2835823e0061
- Updated sound/usb/quirks.c

#### Update 12.02.2018/ gkkpch

- Updated sound/usb/quirks.c

#### Experimental update 17.02.2018/ gkkpch

- Bumped to 4.12.9+
- Added patch for Intel CherryTrail SST Audio, incl. ES8316 codec
- Added additional (NEW) configuration option to the kernel.
- Fixing pops with DSD files, manually patched /sound/usb/endpoint.c with the contents of this patch:
  https://github.com/Fourdee/linux/commit/70a8155a64fc3fde57f69f91da3b2835823e0061
- Updated sound/usb/quirks.c
- Saved changes as a patch-file

#### Experimental update 22.02.2018/ gkkpch

- Small additions, remove "diff" file

#### Experimental update 13.04.2018/ gkkpch

- First version with kernel 4.16
- Includes latest DSD additions
- Includes working Baytrail/ Cherrytrail audio devices for Intel SST
- Includes SD support
- Firmware (removed from kernel as per 4.13) moved to the X86 build scripts

#### Prepare for Debian stretch 27.07.2018

- Split packages for X86 jessie and stretch (old/new kernel) in two separate folders

#### First platform package for Debian stretch 16.09.2018

- linux-firmware-stretch.xz replacing the firmware folder (which can be deleted later)

#### Cleaned up firmware

- Cleaned up and renamed linux-firmware-stretch.xz to linux-firmware-stretch.tar.xz

#### Debian Stretch dismissed/ Jessie with new kernel gkkpch 03.12.2018

- Kernel Version 4.19.y, current 4.19.37, for current Debian Jessie distro (platform-nk)

#### Abandoned Debian stretch 08.10.2019
Added kernel packages for Debian Buster
- Current kernel version 4.19.76

- 20191018	Bumped kernel version to 4.19.79
- 20191125	Bumped kernel version to 5.4.0
- 20200123	Bumped kernel version to 5.4.13 + firmware updates
- 20200210	Bumped kernel version to 5.4.18
- 20200219	Reverting to kernel version 4.19.104 because of boot issues with 5.4.y
- 20200224	Bumping to 4.19.106, adding a patch for intel 3138 wifi
(https://patchwork.kernel.org/patch/11353871/ )
- 20200604	Bumped to 4.19.126
- 20201223	Bumped to 4.19.126 (i386 + amd64)
- 20201224	Updated to firmware_20201218 (kernel.org)/ simplified grub.cfg
- 20201229	Bumped to 4.19.164 and 5.10.4 (i386 + amd64)
- 20210105	Updated kernel configuration/ corrections for 5.10.4-i386
- 20210115	Updated intel hda soundcards tweaks
- 20210119	Updated intel hda soundcards tweaks, improved AMD support, grub.cfg cosmetics
- 20210122	Bumped to kernel 5.10.9, removed a load of irrelevant modules from kernel config
- 20210209	(grub.cfg) Removed kernel version from image name (fixed 'vmlinuz')
- 20210216	Bumped to kernel 5.10.16, added RTL8821CE/8822CE
- 20210217  Bumped to kernel 5.10.17 (i386/amd64) for beta testing
- 20210226	Alsa UCM: modified bytcr-init.sh
- 20210227	Alsa UCM: modified bytcr-init.sh/ bytcht-es8316 additions
- 20210305	Bumped to 5.10.20 x86_amd64, removed i386 (for the beta, may add later)
- 20210308	On request: added VIRTIO_NET and VIRTIO_BLK drivers
- 20210409	Bumped to 5.10.28/ cherrytrail init update (es8316)
- 20210412	Optimized x5-z8350 machines with rt5640 codec: auto jack detection for switching output
- 20210508	Bumped to 5.10.35
- 20210821	Bumped to 5.10.60
- 20210915	Bumped to 5.10.68
- 20211006	Bumped to 5.10.70
- 20211012	Added Z83-II specific "brcmfmac43455-sdio.AZW-Z83 II.txt" to broadcom nvram
- 20211019	Completed soundcard "HD-Generic Audio" profile
- 20211026 Support for audio: cht-bsw-rt5672 + C-Media, improved jack detection (bytcr/cht), new AMD firmware, kernel 5.10.79
- 20211224 Bumped to 5.10.88, added Broadcom Tigon Ethernet PHY support
- 20220115 Bumped to 5.10.91, added Realtek RTL88x2BU wireless support
- 20220116 Bumped to 5.10.92, added Realtek drivers RTL8723DU/RTL8811CU/RTL88XXAU
- 20220131 Bumped to 5.10.95, fixed RTL8812AU/RTL8814AU/RTL8821AU wireless driver
- 20220404 Bumped to 5.10.109, added patch for Cambridge USB Audio devices
- 20220420 Bumped to 5.10.112, enabled Intel i225-lm/ i225-v ethernet controllers







