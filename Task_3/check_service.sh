#####################################################################
# Script Name : service_status.sh
# Version     : 3.0
# Date        : 28 Oct 2025
# Purpose     : script that checks whether a specified service is running and restarts it if it's not running.
####################################################################

#!/bin/bash

service_name=$1

if [ "$#" -ne 1 ] || ! command -v systemctl &> /dev/null; then
    echo "Usage: $0 service_name"
    ! command -v systemctl &> /dev/null && echo "Error: systemctl not found. This script works only on systems using systemd."
    exit 1
fi

echo Checking Whether the $service_name is Running Or Not

if pgrep -x $service_name >/dev/null
        then
        echo "$service_name is running."
else
        echo "$service_name is not running"
        systemctl start $service_name
        if pgrep -x $service_name >/dev/null
                then
                        echo "$service_name is restarted"
                else
                        echo "$service_name is not restarted."
        fi
fi
