
/telegraf/usr/bin/telegraf &

mkdir -p /run/mysqld
mkdir -p /var/lib/mysql

if [ ! -d /var/lib/mysql/mysql ]
then
    echo '-----------INSTALL-----------'
    mysql_install_db --user=root --datadir=/var/lib/mysql

    echo '-----------SETUP-----------'
    /usr/bin/mysqld --user=root --datadir=/var/lib/mysql --bootstrap <<EOF
FLUSH PRIVILEGES;
CREATE DATABASE wordpress;
CREATE USER 'root'@'%' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'%' IDENTIFIED BY 'root';
FLUSH PRIVILEGES;
EOF

    echo '-----------SETUP WORDPRESS-----------'
    /usr/bin/mysqld --user=root --datadir=/var/lib/mysql --bootstrap < ./wordpress.sql
fi

echo '-----------DEAMON-----------'
exec /usr/bin/mysqld --user=root --datadir=/var/lib/mysql

# Setup MySQL
#/usr/bin/mysql_install_db --datadir=/var/lib/mysql

# Start MySQL in background
#/usr/bin/mysqld --user=root --init_file=/init_db.sql & sleep 30

# Initialize database
#mysqld --user=root --bootstrap
#mysql wordpress -u root < wordpress.sql

# Keep container running
#tail -f /dev/null

#mysql_install_db --user=root --ldata=/var/lib/mysql

#mysqld --user=root --bootstrap < init_db.sql

#mysqld --user=root --console --skip-networking=0 --port=3306 --datadir=/var/lib/mysql --bind-address=0.0.0.0
