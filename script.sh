#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
N="\e[0m"

CHECK_ROOT(){
    
    if [ $USERID -ne 0 ]
    then 
        echo "run the script with root privileges"
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R failed $N"
    else
        echo -e "$2 is $G success $N"
    fi
}

CHECK_ROOT

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed and going to install it"
    dnf install mysql -y
    VALIDATE $? "installing mysql"
else
    echo "mysql is already installed."
fi

dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "nginx is not installed and going to install it"
    dnf install nginxx -y
    VALIDATE $? "installing nginx"
else
    echo "nginx is already installed"
fi
