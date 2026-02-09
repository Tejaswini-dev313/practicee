#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Run the scrip with root priveleges"
    exit 1
fi 

dnf install nginx -y

if [$? -ne 0 ]
then
    echo "nginx installtion is failed"
else
    echo "successfully installed the nginx"
fi