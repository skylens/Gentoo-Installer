#! /bin/bash
# http://archives.seul.org/seul/project/Feb-1998/msg00069.html
function checkuse()
{
	[ $(id -u) != "0" ] && { whiptail --title "错误" --backtitle "Gentoo 安装程序" --msgbox "需要 root 用户权限，是否退出？" 10 60; exit 1; }
}
#checkuse
function start_install()
{
	whiptail --title "Gentoo 安装程序" --backtitle "Gentoo 安装程序" --yes-button "安装" --no-button "退出" --yesno "欢迎使用 Gentoo TUI 安装程序"  10 35
}
if (start_install)
then
	whiptail --title "分区" --backtitle "Gentoo 安装程序" --yes-button "继续" --no-button "退出" --yesno "你磁盘的数据已经备份好了？该不操作将会格式化你的磁盘！" 10 40
	
elif(whiptail --title "Gentoo 安装程序" --backtitle "Gentoo 安装程序" --yesno "确定要退出?" 7 40)
then
        start_install
else
        exit 1;
fi
