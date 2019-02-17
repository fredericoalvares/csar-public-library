#!/bin/bash -e

sudo systemctl stop influxdb

DEFAULT_API_PORT=8086 
DEFAULT_RCP_PORT=8088 

CONF_FILE="/etc/influxdb/influxdb.conf"

if [[ ("$API_PORT" == "$DEFAULT_API_PORT") ]]; then
  echo "Use default API port : $DEFAULT_API_PORT"
else
  echo "Replacing API port $DEFAULT_API_PORT with $API_PORT..."
  sudo sed -i -e "s/$DEFAULT_API_PORT/$API_PORT/g" $CONF_FILE || exit ${1}
fi

if [[ ("$RCP_PORT" == "$DEFAULT_RCP_PORT") ]]; then
  echo "Use default RCP port : $DEFAULT_RCP_PORT"
else
  echo "Replacing RCP port $DEFAULT_RCP_PORT with $RCP_PORT..."
  sudo sed -i -e "s/$DEFAULT_RCP_PORT/$RCP_PORT/g" $CONF_FILE || exit ${1}
fi

echo "Start influxdb whith new conf"
sudo service influxdb start
echo "End of $0"

