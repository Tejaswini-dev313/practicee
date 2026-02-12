#!/bin/bash

set -e

failure(){
    echo "Failed at : $1:$2"
}

trap 'failure "${LINENO}" "$BASH_COMMAND"' ERR

echo "Hello world success"
echooo "Hello world success"
echo "Hello world after failure"




# trap 'failure "${LINENO}" "$BASH_COMMAND"' ERR #ERR is the error signal

# echo "Hello world success"
# echooo "Hello world success"
# echo "Hello world after failure"