#! /bin/bash
# http://archives.seul.org/seul/project/Feb-1998/msg00069.html
function test()
{
}

if (whiptail --title "Gentoo 安装程序" --backtitle "感谢使用" --yesno "安装前请先备份数据"  10 40)
then
        echo -e "\n继续!\n"
elif(whiptail --title "Gentoo 安装程序" --backtitle "感谢使用" --yesno "确定要退出?" 7 40)
then
        echo -e "\n是的!\n"
else
        echo -e "\n不退出\n"
fi
