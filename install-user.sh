#!/bin/bash
echo 'make time'
timedatectl set-ntp true

echo 'creat user k'
useradd -g users -G wheel,storage,power -m k

passwd k

echo 'make network'
systemctl start NetworkManager.service
systemctl enable NetworkManager.service

pacman -S sudo

echo 'edit sudoer'
EDITOR=vim visudo
