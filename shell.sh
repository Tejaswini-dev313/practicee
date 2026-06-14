#!/bin/bash

SOURCE_DIR=

if [ -d $SOURCE_DIR ]
then
    echo "$SOURCE_DIR is exist"
else
    echo "$SOURCE_DIR doesn't exist...please check"
fi

FILES=$(find $SOURCE_DIR | cut -d "*.log" -f1 -mtime +14)
echo "File: $FILES"

while IFS= read -r line
do
    echo "Deleting line: $line"
    rm -rf $line
done