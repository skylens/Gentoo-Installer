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

```

## 6. mirror configure

```sh
echo 'Server = http://mirrors.aliyun.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo 'Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
```

## 7. arch

```sh
pacman -Sy archlinux-keyring
```

## 8. install base

## 9. chroot
