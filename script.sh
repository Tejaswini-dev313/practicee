#!/bin/bash

userid=$(id -u)

if [ $userid -ne 0 ]
then 
 echo "run the script with root priveleges"
 exit 1
fi

dnf list installed mysql

if [ $? -ne 0 ]
then 
    echo "mysql is not installed..going to install it"
    dnf install mysql -y
else
    echo "mysql is alredy installed"
fi 



