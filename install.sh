#!/bin/bash

# 必须先同步时间，否则后面加入中国源不行
timedatectl set-ntp true
chmod +x ./install-root.sh
chmod +x ./install-user.sh
chmod +x ./afterinstall.sh
# 格式化硬盘
echo yes | mkfs.ext4 /dev/mmcblk0p2
mkfs.fat -F32 /dev/mmcblk0p1
# 挂载硬盘和分区
mount /dev/mmcblk0p2 /mnt
mkdir /mnt/boot
mount /dev/mmcblk0p1 /mnt/boot

# 中国源
#cp ./data/mirrorlist /etc/pacman.d/mirrorlist
sed -i '1iServer = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist


# 开始安装核心组件
pacstrap /mnt base linux linux-firmware vim networkmanager git networkmanager grub efibootmgr
echo 'linux install done'
genfstab -U /mnt >> /mnt/etc/fstab

# 进入未来root
echo 'enter root'
cd /mnt/home
mkdir install
cd install
cp -r /root/install-none-os/* ./
arch-chroot /mnt
