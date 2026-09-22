#!/bin/bash

user=$(id -u)

if [ $user -ne 0 ]
then
    echo "run the script with root privileges"
    exit 1
fi

for package in "$@"
do
    dnf list installed $package

    if [ $? -ne 0 ]
    then
        echo "package is not installed. install $package"
        dnf install $package -y
    else
        echo "$package package is already installed. nothing to do"
    fi
done