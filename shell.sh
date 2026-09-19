#!/bin/bash/

userid=$(id -u)

R=\e[31m
G=\e[32m
N=\e[0m

check_root(){

if [ $userid -ne 0 ]
then 
    echo "run the script with root previliges"
    exit 1
fi
}

check_root

validate(){

    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R failed $N"
        exit 1
    else
        echo -e "$2 is $G success $N"
    fi
}

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed. install mysql"
    dnf install mysql -y
    validate $? "installing mysql" 
else
    echo "mysql is already installed"
fi
