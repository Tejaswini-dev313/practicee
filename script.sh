#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGS_DATE=$(date)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$LOGS_DATE.log"

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo "Run the script with root privileges" | tee -a $LOG_FILE
    exit 1
fi

VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R failed $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 is $G success $N" | tee -a $LOG_FILE
    fi
}

USAGE() {

    echo -e "$R USAGE:: $N sudo sh script.sh Package1 Package2..."
    exit 1
}

echo "Script started executing at: $(date)" | tee -a $LOG_FILE

for Package in $@
do 
    dnf list installed $Package | tee -a $LOG_FILE
    if [ $? -ne 0 ]
    then 
        echo "Package is not installed. installing the $Package"
        dnf install $Package -y         | tee -a $LOG_FILE
        VALIDATE $? "Installing $Package"
    else
        echo "$Package is already installed. nothing to do.."   | tee -a $LOG_FILE
    fi
done

