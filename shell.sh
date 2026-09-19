#!/bin/bash/

userid=$(id -u)

check_root(){

if [ $userid -ne 0 ]
then 
    echo "run the script with root previliges"
    exit 1
fi
}

check_root

if [ $1 -ne 0 ]
then
    echo "$2 is failed"
    exit 1
else
    echo "$2 is success"
fi

validate(){

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed. install mysql"
    dnf install mysql -y
    validate $? installation 
else
    echo "mysql is already installed"
fi
} 