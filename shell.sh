#!/bin/bash/

USER=$(id -u)

if [ $USER -ne 0 ]
then
    echo "Run the script with root priveleges"
    exit 1
fi

dnf install nginx -y

if [ $? -ne 0 ]
then 
    echo "installation has been failed..check the command"
else
    echo "installing successfully"
fi
