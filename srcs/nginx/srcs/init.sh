#!/bin/sh

echo "root:password" | chpasswd
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

/telegraf/usr/bin/telegraf &

openrc
touch /run/openrc/softlevel
/etc/init.d/sshd start

nginx -t || exit 1
nginx -g 'daemon off;'