#!/bin/bash -e

service="influxdb"

if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
  sudo systemctl restart $service
else
  sudo systemctl start $service
fi
