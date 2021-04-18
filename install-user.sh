#!/bin/bash

sudo timedatectl set-ntp true

useradd -g users -G wheel,storage,power -m k

passwd k

systemctl start NetworkManager.service
systemctl enable NetworkManager.service

vim /etc/sudoers
