#! /bin/bash

OWN_IP_ADDR=`ip addr show eth0 | egrep -o '[0-9]+(\.[0-9]+){3}'`

cmd="java -jar /home/distributeddatamgr.jar -c"

eval echo '$cmd'
eval exec $cmd

#COPYRIGHT Fujitsu Limited 2017 and FUJITSU LABORATORIES LTD. 2017