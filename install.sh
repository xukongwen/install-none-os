#!/bin/bash

# 必须先同步时间，否则后面加入中国源不行
timedatectl set-ntp true

# 格式化硬盘
echo yes | mkfs.ext4 /dev/mmcblk0p2
mkfs.fat -F32 /dev/mmcblk0p1
# 挂载硬盘和分区
mount /dev/mmcblk0p2 /mnt
mkdir /mnt/boot
mount /dev/mmcblk0p1 /boot

# 中国源 
#cp ./data/mirrorlist /etc/pacman.d/mirrorlist
sed -i '1iServer = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist


# 开始安装核心组件
pacstrap /mnt base linux linux-firmware vim networkmanager
echo 'linux install done'
genfstab -U /mnt >> /mnt/etc/fstab

# 进入未来root
echo 'enter root'
arch-chroot /mnt
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
pacman -S grub efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg


echo 'this is ok?'





