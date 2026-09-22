#!/bin/bash

source_dir="/var/log/shell_script"

if [ -d $source_dir ]
then 
	echo "directory has existed"
else
	echo "Directory not found"
fi

FILE=$(find $source_dir -name ".log")
echo "file:$FILE"

while IFS= read -r line
do 
	
	echo "deleting the file $line"
	rm -rf $line
	
done <<< $FILE