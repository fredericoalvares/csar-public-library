#!/bin/bash -e

sudo systemctl stop influxdb

DEFAULT_API_PORT=8086 
DEFAULT_RCP_PORT=8088 

ORIGINAL_PATH="\/var\/lib\/influxdb\/"
DEFAULT_PATH="\/mountedStorageNb\/influxdb\/"



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


echo "Replacing data and meta path..."
sudo sed -i -e "s/dir = \"${ORIGINAL_PATH}meta\"/dir = \"${DEFAULT_PATH}meta\"/g" $CONF_FILE || exit ${1}
sudo sed -i -e "s/dir = \"${ORIGINAL_PATH}data\"/dir = \"${DEFAULT_PATH}data\"/g" $CONF_FILE || exit ${1}
sudo sed -i -e "s/wal-dir = \"${ORIGINAL_PATH}wal\"/wal-dir = \"${DEFAULT_PATH}wal\"/g" $CONF_FILE || exit ${1}



cat $CONF_FILE


echo "Start influxdb whith new conf"
sudo service influxdb start
echo "End of $0"

