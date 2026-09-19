#!/bin/bash/

userid=$(id -u)

if [ $userid -ne 0 ]
then 
    echo "run the script with root previliges"
    exit 1
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed. install mysql"
    dnf install mysql -y
else
    echo "mysql is already installed"
fi