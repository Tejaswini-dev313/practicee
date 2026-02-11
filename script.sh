#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo "Run the script with root preveleges"
    exit 1
fi

VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo "$2 is.. Failed"
        exit 1
    else
        echo "$2 is.. Success"
    fi
}

dnf list installed git 

if [ $? -ne 0 ]
then 
    echo "nginx is not installed...installing the nginx"
    dnf install nginx -y
    VALIDATE $? "installing nginx"
else
    echo "nginx already installed"
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed and installing."
    dnf install mysql -y
    VALIDATE $? "installing mysql"
else
    echo "mysql already installed and nothing to do"
fi


