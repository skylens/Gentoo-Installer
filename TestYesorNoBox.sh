#!/bin/bash
if (whiptail --title "Gentoo Install" --yesno "It's dangerous!Please backup you data!Whether to continue install ?" 10 60) then
	    echo "You chose Yes. Exit status was $?."
else
	    echo "You chose No. Exit status was $?."
fi
