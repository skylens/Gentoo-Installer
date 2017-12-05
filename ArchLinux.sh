#!/usr/bin/env bash
# UEFI install
# partion
parted -s -a optimal -- /dev/sda mklabel gpt
parted -s -a optimal -- /dev/sda unit mib mkpart primary 1 129 name 1 boot
parted -s -a optimal -- /dev/sda unit mib mkpart primary 129 1153 name 2 swap
parted -s -a optimal -- /dev/sda unit mib mkpart primary 1153 -1 name 3 rootfs
parted -s -a optimal -- /dev/sda set 1 boot on
# formate
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2 && swapon /dev/sda2
mkfs.ext4 /dev/sda3
# mount
mount -v /dev/sda3 /mnt
mkdir -p /mnt/boot/efi
mount -v /dev/sda1 /mnt/boot/efi
# download
curl -o archlinux.tar.gz http://cs3.swfu.edu.cn/~20141155028/archlinux.tar.gz
tar -zxvf archlinux.tar.gz
cd archlinux
# update repos
cat mirrorlist > /etc/pacman.d/mirrorlist
pacman -Syy
# install base system
pacstrap /mnt base base-devel --force
# fstab
genfstab -p /mnt >> /mnt/etc/fstab
# uodate repos again
cat mirrorlist > /mnt/etc/pacman.d/mirrorlist
# language
cat locale.gen > /mnt/etc/locale.gen
echo "LANG=zh_CN.UTF-8" > /mnt/etc/locale.conf
# setting
mv archlinuxconfig.sh /mnt/root/archlinuxconfig.sh
chmod +x /mnt/root/archlinuxconfig.sh
arch-chroot /mnt /root/archlinuxconfig.sh
