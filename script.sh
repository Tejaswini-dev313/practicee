#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
N="\e[0m"

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo "Please run the script with root privileges"
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

for Package in $@
do
    dnf list installed $@
    
    if [ $? -ne 0 ]
    then 
        echo "$Package is not installed..please check"
        dnf install $Package -y
        VALIDATE $? "installing $Package"
    else
        echo "$Package is already installed"
    fi
done
