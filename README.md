# Arach Linux UEFI Install

## 1. get Arch Linux iso

[Offical](https://www.archlinux.org/download/)

[Aliyun Mirrors](https://mirrors.aliyun.com/archlinux/iso/latest/)

[USTC Mirrors](https://mirrors.ustc.edu.cn/archlinux/iso/latest/)

[TTUNA Mirrors](https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/)

## 2. network configure 

## 3. start sshd

```sh
systemctl start sshd
```

## 4. setting root password

```sh
passwd root
```

## 5. partation

```sh
parted -s -a optimal -- /dev/sda mklabel gpt
parted -s -a optimal -- /dev/sda unit mib mkpart primary 1 129 name 1 boot
parted -s -a optimal -- /dev/sda unit mib mkpart primary 129 1153 name 2 swap
parted -s -a optimal -- /dev/sda unit mib mkpart primary 1153 -1 name 3 rootfs
parted -s -a optimal -- /dev/sda set 1 boot on
```

## 6. formate disk

```sh
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2 && swapon /dev/sda2
mkfs.ext4 /dev/sda3
```

## 7. mount disk

```sh
mount -v /dev/sda3 /mnt
mkdir -p /mnt/boot/efi
mount -v /dev/sda1 /mnt/boot/efi
```

## 8. mirror configure

```sh
echo 'Server = http://mirrors.aliyun.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo 'Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
```

## 9. arch

```sh
pacman -Syy
pacman -Sy archlinux-keyring
```

## 10. install base

```sh
pacstrap /mnt base base-devel --force
```

## 11. fstab

```sh
genfstab -p /mnt >> /mnt/etc/fstab
```

## 12. localtation

```sh
echo 'en_US.UTF-8' > /mnt/etc/locale.gen
echo 'zh_CN.GB18030' >> /mnt/etc/locale.gen
echo 'zh_CN.UTF-8' >> /mnt/etc/locale.gen
```

## 12. chroot

```sh
arch-chroot /mnt
```

## 13. after chroot setting

```sh
locale-gen
echo "LANG=zh_CN.UTF-8" > /etc/locale.conf
timedatectl set-timezone Asia/Shanghai
timedatectl set-ntp 1
echo 'Server = http://mirrors.aliyun.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo 'Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
pacman -Syy
mkinitcpio –p linux
pacman -S --noconfirm sudo vim git efibootmgr dosfstools os-prober openssh -y
echo LOCAL > /etc/hostname
echo "root:1" | chpasswd
useradd -m -g wheel skylens
usermod -aG root,bin,daemon,tty,disk,network,video,audio skylens
echo "skylens:1" | chpasswd
sed -i 's/\# \%wheel ALL=(ALL) ALL/\%wheel ALL=(ALL) ALL/g' /etc/sudoers
```
