#!/bin/sh

/telegraf/usr/bin/telegraf &

#pure-ftpd -p 21000:21000
pure-ftpd -p 21000:21005 -P 192.168.99.230 -Y 2