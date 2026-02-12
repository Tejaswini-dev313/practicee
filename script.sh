#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo "Run the script with root privileges"
    exit 1
fi

VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R failed $N"
        exit 1
    else
        echo -e "$2 is $G success $N"
    fi
}

for Package in $@
do 
    dnf list installed $Package
    if [ $? -ne 0 ]
    then 
        echo "Package is not installed. installing the $Package"
        dnf install $Package -y
        VALIDATE $? "Installing $Package"
    else
        echo "$Package is already installed. nothing to do.."
    fi
done

