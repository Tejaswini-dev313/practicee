#!/bin/bash

userid=$(id -u)

R="\e[31m"
G="\e[32m"
B="\e[34m"
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
    echo -e "$B mysql is already installed $N"
fi

dnf list installed git

if [ $? -ne 0 ]
then 
    echo "git is not installed and going to install it"
    dnf install git -y
    VALIDATE $? "insttalling git"
else
    echo "git already installed"
fi
 



