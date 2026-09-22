#!/bin/bash

user=$(id -u)

if [ $user -ne 0 ]
then
    echo "given user is not root user"
    exit 1
else
    echo "given user is root user"
fi