#!/bin/bash

ARRAY=("Apple", "kiwi", "orange")

echo "First fruit is ${ARRAY[0]}"
echo "second fruit is ${ARRAY[1]}"
echo "third fruit is ${ARRAY[2]}"

echo "Total fruit is ${ARRAY[@]}"