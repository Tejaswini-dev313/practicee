#!/bin/bash

set -e

failure(){
    echo "failed at $1:$2"
}

trap 'FAILURE "${LINENO}" "${BASH_COMMAND}"' ERR

ls

lsss

ls -la