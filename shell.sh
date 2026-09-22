#!/bin/bash

user=$(id -u)

if [ $user -ne 0 ]
then
    echo "given user is not root user"
    exit 1
else
    echo "given user is root user"
fi

dnf list intalled mysql

if [ $? -ne 0 ]
then
    echo "package is not installed. install mysql"
    dnf install mysql -y
else
    echo "mysql package is already installed. nothing to do"
fi