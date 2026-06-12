#!/bin/bash

userid=$(id -u)

R="\e[31m"
G="\e[32m"
N="\e[0m"

CHECK_ROOT(){
    if [ $userid -ne 0 ]
    then 
        echo "run the script with root priveleges"
        exit 1
    fi
}





