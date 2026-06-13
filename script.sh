#!/bin/bash

LOG_FOLDER="/var/log/expense"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date)
LOGS="$LOG_FOLDER/$SCRIPT_NAME-$TUNESTAMP.log"
mkdir -p $LOG_FOLDER

USERID=$(id -u)

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then 
        echo "Please run the script with root priveleges" | tee -a $LOGS
        exit 1
    fi
}

CHECK_ROOT

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 is failed" | tee -a $LOGS
    else
        echo "$2 is success" | tee -a $LOGS
    fi
}

echo "script started executing at: $(date)" | tee -a $LOGS

dnf install mysql-server -y &>> $LOGS
VALIDATE $? "installing mysql"

systemctl enable mysqld | tee -a $LOGS
VALIDATE $? "Enabled mysql"

systemctl start mysqld | tee -a $LOGS
VALIDATE $? "started mysql"

mysql -h 172.31.20.153 -u root -pExpenseApp@1 -e 'show databases;'

if [ $? -ne 0 ]
then
    echo "mysql password not setup and setting up the password"
    mysql_secure_installation --set-root-pass ExpenseApp@1
    VALIDATE $? "setting up root password"
else
    echo "mysql password already setup...SKIPPING"
fi 

