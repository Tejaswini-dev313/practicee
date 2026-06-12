#!/bin/bash

userid=$(id -u)

R="\e[31m"
G="\e[32m"
B="\e[34m"
N="\e[0m"

CHECK_ROOT(){
    if [ $userid -ne 0 ]
    then 
        echo "run the script with root priveleges"
        exit 1
    fi
}

CHECK_ROOT

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R failed $N"
    else
        echo -e "$2 is $G success $N"
    fi
}

for Package in @
do

dnf list installed $Package

if [ $Package -ne 0 ]
then
    echo "$Package is not installed and going to install it"
    dnf install $Package -y
    VALIDATE $? "$Package is installing"
else
    echo "$Package is already installed"
fi

done
