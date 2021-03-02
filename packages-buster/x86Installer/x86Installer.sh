#!/bin/bash

set -eo pipefail
set -o errtrace


trap 'exit_error $LINENO' INT ERR

isMounted() {
  findmnt -rno SOURCE,TARGET "$1" >/dev/null;
}

exit_error() {
  /bin/echo "x86Installer '${task}' failed at lineno: $1"

  if isMounted /tmp/boot; then
    /bin/umount /tmp/boot
  fi

  if isMounted /tmp/volumio; then
    /bin/umount /tmp/volumio
  fi

  [ -d "/tmp/boot" ] && /bin/rm -r /tmp/boot
  [ -d "/tmp/volumio" ] && /bin/rm -r /tmp/volumio

}

if [ "$#" -ne 8 ]; then
  /bin/echo "Incorrect number of parameters"
  exit 1
fi

# Wipe the partition table
/bin/dd if=/dev/zero of=$1 count=512 > /dev/null 2>&1
/bin/echo "5" > /tmp/install_progress

# Re-partition
/sbin/parted -s ${1} mklabel "${2}"
/bin/echo "10" > /tmp/install_progress
/sbin/parted -s ${1} mkpart primary fat32 ${3} ${4}
/bin/echo "13" > /tmp/install_progress
/sbin/parted -s ${1} mkpart primary ext3  ${4} ${5}
/bin/echo "16" > /tmp/install_progress
/sbin/parted -s ${1} mkpart primary ext3  ${5} 100%
/bin/echo "20" > /tmp/install_progress
/sbin/parted -s ${1} set 1 boot on
/sbin/parted -s ${1} set 1 legacy_boot on
sync
/sbin/partprobe ${1}
sleep 3

# Create filesystems
/bin/echo "25" > /tmp/install_progress
/sbin/mkfs -t vfat -F 32 -n boot ${6} > /dev/null 2>&1
/bin/echo "30" > /tmp/install_progress
/sbin/mkfs -F -t ext4 -L volumio ${7} > /dev/null 2>&1
/bin/echo "35" > /tmp/install_progress
/sbin/mkfs -F -t ext4 -L volumio_data ${8} > /dev/null 2>&1
/bin/echo "40" > /tmp/install_progress

# Install syslinux
/bin/dd conv=notrunc bs=440 count=1 if=/usr/lib/syslinux/mbr/gptmbr.bin of=${1} > /dev/null 2>&1
/usr/bin/syslinux ${6}
/bin/echo "50" > /tmp/install_progress

# Mount boot and image partition
/bin/mkdir /tmp/boot
/bin/mkdir /tmp/volumio
/bin/mount $6 /tmp/boot
/bin/mount $7 /tmp/volumio
/bin/echo "55" > /tmp/install_progress

# Install current boot partition
/bin/tar xf /imgpart/kernel_current.tar -C /tmp/boot > /dev/null 2>&1
/bin/echo "65" > /tmp/install_progress

# Copy current squash file
/bin/cp -r /imgpart/* /tmp/volumio
/bin/echo "85" > /tmp/install_progress

# Update UUIDs
uuid_boot=$(/sbin/blkid -s UUID -o value ${6})
uuid_img=$(/sbin/blkid -s UUID -o value ${7})
uuid_data=$(/sbin/blkid -s UUID -o value ${8})

/bin/cp /tmp/boot/syslinux.tmpl /tmp/boot/syslinux.cfg
/bin/sed -i "s/%%IMGPART%%/${uuid_img}/g" /tmp/boot/syslinux.cfg
/bin/sed -i "s/%%BOOTPART%%/${uuid_boot}/g" /tmp/boot/syslinux.cfg
/bin/sed -i "s/%%DATAPART%%/${uuid_data}/g" /tmp/boot/syslinux.cfg
/bin/echo "95" > /tmp/install_progress

/bin/cp /tmp/boot/efi/BOOT/grub.tmpl /tmp/boot/efi/BOOT/grub.cfg
/bin/sed -i "s/%%IMGPART%%/${uuid_img}/g" /tmp/boot/efi/BOOT/grub.cfg
/bin/sed -i "s/%%BOOTPART%%/${uuid_boot}/g" /tmp/boot/efi/BOOT/grub.cfg
/bin/sed -i "s/%%DATAPART%%/${uuid_data}/g" /tmp/boot/efi/BOOT/grub.cfg

/bin/echo "99" > /tmp/install_progress

/bin/rm -r /tmp/volumio/lost+found
/bin/umount /tmp/boot
/bin/umount /tmp/volumio
/bin/rm -r /tmp/boot
/bin/rm -r /tmp/volumio

sleep 1




