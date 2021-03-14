#!/bin/sh

/telegraf/usr/bin/telegraf &

openrc
touch /run/openrc/softlevel

rc-update add php-fpm7 default
rc-service php-fpm7 restart

nginx -t || exit 1

nginx -g 'daemon off;'