#!/bin/bash

USERID=$(id -u)

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
        echo "$2 is success"
    else
        echo "$2 is...failed"
    fi
}

CHECK_ROOT

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed and going to install it"
    dnf install mysql -y
    VALIDATE $? "installing git"
else
    echo "mysql is already installed."
fi

dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "nginx is not installed and going to install it"
    dnf install nginx -y
    VALIDATE $? "installing nginx"
else
    echo "nginx is already installed"
fi
