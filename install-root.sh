#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo 'set clock'
hwclock --systohc
echo 'set lan'
sed -i '1ien_US.UTF-8 UTF-8' /etc/locale.gen

locale-gen

echo 'LANG=en_US.UTF-8' > /etc/locale.conf
echo 'make host'
echo 'none' > /etc/hostname

echo '127.0.0.1       localhost' > /etc/hosts
echo '::1             localhost' > /etc/hosts
echo '127.0.1.1       none.localdomain        none' > /etc/hosts

mkinitcpio -P
echo 'input pass'
passwd
echo 'make grub'
echo y | pacman -S grub efibootmgr sudo

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg

mkdir -p /boot/EFI/BOOT
mv /boot/EFI/GRUB/grubx64.efi /boot/EFI/BOOT/BOOTX64.EFI


echo 'root install done'

exit
