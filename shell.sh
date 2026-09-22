#!/bin/bash

R="\e[31m"
G="\e[32m"
N="\e[0m"

failure(){
    echo "failed at $1:$2"
    
}

trap 'failure ${LINENO} "$BASH_COMMAND"' ERR

echo "Hello world 1"
echo "hello000 world 2"
echo "Hello world 3"