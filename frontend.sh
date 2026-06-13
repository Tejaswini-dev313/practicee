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

dnf install nginx -y &>> $LOGS
VALIDATE $? "installed nginx" | tee -a $LOGS

systemctl enable nginx &>> $LOGS
VALIDATE $? "enabled nginx" | tee -a $LOGS

systemctl start nginx &>> $LOGS
VALIDATE $? "started nginx" | tee -a $LOGS

rm -rf /usr/share/nginx/html/* &>> $LOGS
VALIDATE $? "removing default nginx" | tee -a $LOGS

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip

cd /usr/share/nginx/html &>> $LOGS

unzip /tmp/frontend.zip &>> $LOGS
VALIDATE $? "unziping the frontend content" | tee -a $LOGS

cp /home/ec2-user/practicee/expense.conf /etc/nginx/default.d/expense.conf

systemctl restart nginx &>> $LOGS
VALIDATE $? "restaring the nginx" | tee -a $LOGS