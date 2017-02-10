##platform-x86

Kernel Sources: http://www.kernel.org, Version 3.18.25

This repo contains all platform-specific files, used by the Volumio Builder 
to create an **X86** image:

- Kernel files (kernel, modules, firmware)
- Other files, e.g. used during the boot process

####15.01.2016/gkkpch

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

####21.01.2016/gkkpch

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




