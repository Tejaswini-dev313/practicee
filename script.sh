#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"


if [ $USERID -ne 0 ]
then
    echo "Run the scrip with root priveleges"
    exit 1
fi 

dnf install nginxx -y

if [$? -ne 0 ]
then
    echo -e "nginx installtion is $R failed $N"
    exit 1
else
    echo -e " $G successfully installed the nginx $N"
fi