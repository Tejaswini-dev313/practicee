#!/bin/bash

user=$(id -u)

if [ $user -ne 0 ]
then
    echo "run the script with root privileges"
    exit 1
fi

dnf list intalled mysql

if [ $? -ne 0 ]
then
    echo "package is not installed. install mysql"
    dnf install mysql -y
else
    echo "mysql package is already installed. nothing to do"
fi