#!/bin/bash

# disk_usage=$(df -hT | grep xfs)
# disk_threshold=1

# while IFS= read -r line
# do 
#     usage=$(echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1)
#     partiation=$(echo $line | awk -F " " '{print $NF}')

#     if [ $disk_usage -ge $disk_threshold ]
#     then
#         echo "$disk_usage is reached the threshold value. please check"
#     fi
# done <<< disk_usage

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=5 

while IFS= read -r line
do
    USAGE=$(echo $line | grep xfs | awk -F " " '{print $6F}' | cut -d "%" -f1)
    PARTITION=$(echo $line | grep xfs | awk -F " " '{print $NF}')
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        echo "$PARTITION is more than $DISK_THRESHOLD, current value: $USAGE, please check"
    fi
done <<< $DISK_USAG