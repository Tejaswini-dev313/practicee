#!/bin/bash

userid=$(id -u)

R="\e[31m"
G="\e[32m"
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

dnf list installed mysql

if [ $? -ne 0 ]
then 
    echo "mysql is not installed and going to install it"
    dnf install mysql -y
    VALIDATE $? "installing mysql"
else
    echo "mysql is already installed"
fi
 



