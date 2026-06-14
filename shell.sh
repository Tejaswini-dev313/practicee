#!/bin/bash

SOURCE_DIR=/home/ec2-user/logs

if [ -d $SOURCE_DIR ]
then
    echo "$SOURCE_DIR is exist"
else
    echo "$SOURCE_DIR doesn't exist...please check"
fi

FILES=$(find /home/ec2-user -name "*.log" -mtime +14)
echo "File: $FILES"

while IFS= read -r line
do
    echo "Deleting line: $line"
    rm -rf $line
done <<< $FILES