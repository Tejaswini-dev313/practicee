#!/bin/bash

LOG_FOLDER="/var/log/shell-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date)
LOGS="$LOG_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOG_FOLDER

userid=$(id -u)

R="\e[31m"
G="\e[32m"
B="\e[34m"
N="\e[0m"

CHECK_ROOT(){
    if [ $userid -ne 0 ]
    then 
        echo "run the script with root priveleges" &>> $LOGS 
        exit 1
    fi
}

CHECK_ROOT

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R failed $N" &>> $LOGS
    else
        echo -e "$2 is $G success $N" &>> $LOGS
    fi
}

USAGE(){
    echo "USAGE:: sudo sh script.sh package1 package2 ..."
    exit 1
}

if [ $# -eq 0 ]
then
    USAGE
fi

for Package in $@
do

dnf list installed $Package &>> $LOGS

if [ $? -ne 0 ]
then
    echo "$Package is not installed and going to install it" &>> $LOGS
    dnf install $Package -y  &>> $LOGS
    VALIDATE $? "$Package is installing" &>> $LOGS
else
    echo "$Package is already installed" &>> $LOGS
fi

done
