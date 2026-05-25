#!/bin/bash

dnf list install mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed. please check.."
    dnf install mysql -y
    if [ $? -ne 0 ]
    then
        echo "mysql has been installed successfully"
    else
        echo "mysql not installed. please check"
    fi
fi