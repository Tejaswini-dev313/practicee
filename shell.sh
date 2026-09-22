#!/bin/bash/

path="/var/log/shell_script"
timestamp=$(date)
script_name=$(echo $0 | cut -d "." -f1)
Log_file="$path/$script_name-$timestamp.log"

mkdir -p $Log_file

userid=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

check_root(){

if [ $userid -ne 0 ]
then 
    echo "run the script with root previliges" | tee -a $Log_file
    exit 1
fi
}

check_root

validate(){

    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R failed $N" | tee -a $Log_file
        exit 1
    else
        echo -e "$2 is $G success $N" | tee -a $Log_file
    fi
}

for package in "$@"
do

dnf list installed $package

if [ $? -ne 0 ]
then
    echo "$package is not installed. installing $package"
    dnf install $package -y
    validate $? "installing $package" 
else
    echo -e "$Y $package is already installed $N" | tee -a $Log_file
fi

dnf remove $package -y

validate $? "removing $package"

if [ $? -ne 0 ]
then 
    echo "$package not deleted. check the issue" | tee -a $Log_file
fi
done