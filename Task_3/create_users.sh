#####################################################################
# Script Name : add_users_from_csv.sh
# Version     : 3.0
# Date        : 28 Oct 2025
# Purpose     : Script to add new users to the system based on a list of names in a CSV file.
####################################################################

#!/bin/bash

CSV_FILE=$1

if  [ "$#" -ne 1 ] || [ ! -f "$CSV_FILE" ] || [ "${CSV_FILE##*.}" !="csv" ]; then
    echo "Usage: $0 <directory-path-to-csv-file>"
    [ ! -f "$CSV_FILE" ] || [ "${CSV_FILE##*.}" 1="csv" ] && echo "Error: csv_file not found!"
    exit 1
fi

while IFS=',' read -r username
do
        if id "$username" &>/dev/null; then
                echo "User '$username' already exists."
        else
                sudo useradd -m "$username"
                echo "User '$username' created successfully."
        fi
done < "$CSV_FILE"
