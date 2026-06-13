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

dnf module disable nodejs -y | tee -a $LOGS
VALIDATE $? "Disabled nodejs"

dnf modulle enable nodejs:20 -y | tee -a $LOGS
VALIDATE $? "Enabled nodejs"

dnf install nodejs -y | tee -a $LOGS
VALIDATE $? "installed nodejs"

id expense &>> $LOGS

if [ $? -ne 0 ]
then
    echo "user expense not add. creating expense user" | tee -a $LOGS
    useradd expense &>> $LOGS
    VALIDATE $? "USER created"
else
    echo "user expense already created"
fi

mkdir -p /app | tee -a $LOGS 
VALIDATE $? "app folder created"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip
VALIDATE $? "Downloading backend application code"

cd /app
rm -rf /app/*
unzip /tmp/backend.zip

npm install | tee -a $LOGS
VALIDATE $? "installed npm"

cp /home/ec2-user/practicee/backend-server /etc/systemd/system/backend.service

dnf install mysql -y | tee -a $LOGS
VALIDATE $? "installed mysql"

mysql -h 172.31.20.153 -uroot -pExpenseApp@1 < /app/schema/backend.sql | tee -a $LOGS

systemctl daemon-reload | tee -a $LOGS
VALIDATE $? "reloading"

systemctl start backend | tee -a $LOGS
VALIDATE $? "starting"

systemctl enable backend | tee -a $LOGS
VALIDATE $? "enabling"

systemctl restart backend | tee -a $LOGS
VALIDATE $? "restarted backend"




