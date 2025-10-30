#####################################################################
# Script Name : disk_alert.sh
# Version     : 3.0
# Date        : 28 Oct 2025
# Purpose     : script to monitor disk usage and send an email alert if usage exceeds a specified threshold.
####################################################################

#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Threshold "
    exit 1
fi

function DISK_MAIL () {
echo -e "Hello All
                This is system generated email, do not reply to this email.
		partitions on host `/bin/hostname` is reached to threshold.
                Kindly take necessary action ASAP to avoid future inconvenience.
                Server Name : - `hostname`
                Server IP :- `ifconfig | grep inet | head -n 1 | awk '{print $2}'`

Thank & Regards

Team CloudEthix"
}

Threshold=$1

df -h / | egrep -v "Filesystem|tmpfs" > /tmp/df.txt
while read C1 C2 C3 C4 C5 C6
do
	CHK=`echo $C5 | cut -d'%' -f1`
	if [[ $CHK -gt $Threshold ]]
	then
		echo -e "\n**********WARNING**********"
		echo -e "\nyour Disk Utilization of $C6 is Reached to Threshold $C5"
		DISK_MAIL
		echo "Mail to User For Disk Alert"
	else
		echo -e "\nYour Disk Utilization is Under Threshold $C5"
	fi
done < /tmp/df.txt
