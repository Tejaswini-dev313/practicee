#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Run the scrip with root priveleges"
    exit 1
fi 