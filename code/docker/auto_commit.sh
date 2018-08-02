#!/bin/bash

# Objective:
#   Automatically commit the docker image changes
#
# Input: [Image Name]
#
# Author: Yu-Chang (Andy) Ho

# check if the input is given
if [ -z "$1" ]
then
    echo "Usage: ./auto_commit.sh [Image Name]"
    exit 1
fi

ID=`docker ps -l | grep "$1" | awk '{print \$1}'`

if [ -z "$ID" ]
then
    echo "No such docker image exist"
    exit 0
fi

docker commit $ID $1