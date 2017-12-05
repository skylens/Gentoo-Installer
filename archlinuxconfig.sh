#!/usr/bin/env bash
# config archlinux
# all default passwd is '1'
pacman -Syy
pacman -S --noconfirm sudo vim git grub efibootmgr dosfstools os-prober openssh -y
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# dual boot windows 
timedatectl set-local-rtc 1 --adjust-system-clock
# UTC
#hwclock --systohc --utc
echo LOCAL > /etc/hostname
echo "root:1" | chpasswd
useradd -m -g wheel skylens
usermod -aG root,bin,daemon,tty,disk,network,video,audio skylens
echo "skylens:1" | chpasswd
sed -i 's/\# \%wheel ALL=(ALL) ALL/\%wheel ALL=(ALL) ALL/g' /etc/sudoers
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux --recheck
grub-mkconfig -o /boot/grub/grub.cfg
echo "the user is 'skylens' and the password is '1'
pleas run 'exit' and 'umount -R /mnt && reboot' !"
