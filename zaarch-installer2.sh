#!/bin/bash

sed -i "#en_US.UTF-8 UTF-8" "en_US.UTF-8 UTF-8" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# time zone
ln -sf /usr/share/zoneinfo/Africa/Cairo /etc/localtime
hwclock --systohc

echo "arch" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1  localhost" >> /etc/hosts
echo "127.0.1.1 arch" >> /etc/hosts

echo "Create Root Password..."
passwd

echo "Installing NetworkManager..."
pacman -S networkmanager
systemctl enable NetworkManager

echo "Insatll BootLoader..."
pacman -S grub efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

echo "Install X Window System..."
pacman -S xorg xorg-xinit xorg-server

echo "Creating New User..."
while true; do
  read -p "Enter Username: " username
  if [[ "$username" =~ ^[a-z_][a-z0-9_-]{0,31}$ ]]
    break
  fi
  echo "Invalid Username, Try Again"
done
useradd -m -G wheel -s /bin/bash $username
passwd $username

export EDITOR=nano
file="/etc/sudoers"
searchLine="# %wheel ALL=(ALL) ALL"
replaceLine="%wheel ALL=(ALL) ALL"
if grep -q "$searchLine" "$file"; then
  sudo sed -i $searchLine $replaceLine $file
fi
exit

