#!/bin/bash

SOURCE_DRIVE=$(df -hT | grep xfs)
THRESHOLD=5

while IFS read -r $line
do 
    USAGE=$(echo "$line | awk -F " " '{print $6F}' | cut -d "%" -f1")
    PARTITION=$(echo $line | grep xfs | awk -F " " '{print $6F}')
    if [ $USAGE -ge $THRESHOLD]
    then
        echo "$PARTITION is more than $THRESHOLD, current value: $USAGE, please check"
    fi
done <<< $SOURCE_DRIVE
    
