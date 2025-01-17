#!/bin/bash

echo "            HI TO ZA-ARCH-INSTALLER"
echo "THIS SCRIPT TO INSTALL BASE ARCH WITH OUT WM"
while true; do
  read -p "Enter Your EFI Partition's Path: " efiPath
  if [ -e "$efiPath" ]; then
    break
  fi
  echo "Partition Not Fount, Try Again: "
done

while true; do
  read -p "Enter Root Partition's Path: " rootPath
  if [ -e "$rootPath" ]; then
    break
  fi
  echo "Partition Not Fount, Try Again"
done


mkfs.fat -F32 $efiPath
mkfs.ext4 $rootPath


mkdir -p /mnt/boot/efi

mount $rootPath /mnt
mount $efiPath /mnt/boot/efi

echo "Base System Packages will be installed -> [ base, linux, linux-firmware, sudo, nano, git ]"
pacstrap /mnt base linux linux-firmware sudo nano git

genfstab -U -p /mnt >> /mnt/etc/fstab

arch-chroot /mnt /bin/bash



