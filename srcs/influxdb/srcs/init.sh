#!/bin/sh

/telegraf/usr/bin/telegraf &

# Start influxdb
#/usr/sbin/influxd & sleep 3

influxd run -config /etc/influxdb.conf

# Initialize database
influx -execute "CREATE DATABASE grafana"
influx -execute "CREATE USER admin WITH PASSWORD 'aaa'"
influx -execute "GRANT ALL ON grafana TO admin"

#