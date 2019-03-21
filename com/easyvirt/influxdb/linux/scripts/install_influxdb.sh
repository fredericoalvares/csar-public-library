#!/bin/bash -e

DISTRIB_ID=$(cat /etc/*-release | sed -n 's/^ID=\(.*\)/\1/p')
DISTRIB_CODENAME=$(cat /etc/*-release | sed -n 's/^VERSION=.*\s(\(.*\))"$/\1/p')
NAME="InfluxDB"
LOCK="/tmp/lockaptget"

#echo "Using apt-get. Installing influxdb on one of the following : ${DISTRIB_ID} / ${DISTRIB_CODENAME}"

#while true; do
#  if mkdir "${LOCK}" &>/dev/null; then
#    echo "$NAME take apt lock"
#    break;
#  fi
#  echo "$NAME waiting apt lock to be released..."
#  sleep 0.5
#done
#
#
#wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
#source /etc/lsb-release
#echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list



#
#
#sudo rm -f /var/lib/dpkg/lock
#sudo apt-get update || (sleep 15; sudo apt-get update || exit ${1})
#sudo apt-get install -y -q influxdb || exit ${1}
wget https://dl.influxdata.com/influxdb/releases/influxdb_1.7.4_amd64.deb

while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do
  echo "$NAME waiting for other software managers to finish..."
  sleep 0.5
done

sudo dpkg -i influxdb_1.7.4_amd64.deb

sudo systemctl unmask influxdb.service

#rm -rf "${LOCK}"
#echo "$NAME released apt lock"

echo "End of $0"
