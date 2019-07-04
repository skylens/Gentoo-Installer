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

## 12. chroot

```sh
arch-chroot /mnt
```

## 13. after chroot setting

```sh
echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
echo 'zh_CN.GB18030 GB18030' >> /etc/locale.gen
echo 'zh_CN.UTF-8 UTF-8' >> /etc/locale.gen
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

## 14. boot

```sh
cp /boot/vmlinuz-* /boot/efi/bootx64.efi
mount | grep efivars
efibootmgr --create --disk /dev/sda --part 3 --label "ArchLinux" --loader "\efi\bootx64.efi"
efibootmgr -c -d /dev/sda -p 3 -L "ArchLinux" -l '\efi\bootx64.efi' -u 'initrd=\initramfs-linux.img'
echo "initrd=\efi\arch\initramfs-linux.img root=/dev/mapper/crypt cryptdevice=/dev/sda3:crypt ro quiet" | iconv -f ascii -t ucs2 | efibootmgr --create --gpt --disk /dev/sda --part 1  --label "Arch Linux" --loader '\efi\arch\vmlinuz-linux.efi' --append-binary-args -
```
