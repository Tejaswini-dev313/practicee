#!/bin/bash

disk_usage=$(df -hT | grep xfs)
disk_threshold=1

while IFS= read -r line
do 
    usage=$(echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1)
    partiation=$(echo $line | awk -F " " '{print $NF}')
    if [ $disk_threshold -ge 1 ]
    then
        echo "$disk_threshold is reached the threshold value. please check"
    fi
done <<< disk_usage
