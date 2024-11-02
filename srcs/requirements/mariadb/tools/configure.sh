#!/usr/bin/env sh

if [ ! -d /var/lib/mysql/$WP_DATABASE ]; then
  mysql_install_db
  /usr/share/mariadb/mysql.server start
  mysql -e "\
    DELETE FROM mysql.user WHERE User=''; \
    DROP DATABASE IF EXISTS test; \
    DELETE FROM mysql.db WHERE Db='test'; \
    CREATE DATABASE IF NOT EXISTS ${WP_DATABASE} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci; \
    CREATE USER '${WP_USER}'@'%' IDENTIFIED BY '${WP_PASSWORD}'; \
    GRANT ALL PRIVILEGES ON ${WP_DATABASE}.* TO '${WP_USER}'@'%'; \
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}'; \
    FLUSH PRIVILEGES; \
    "
  mysqladmin --user=root --password=$SQL_ROOT_PASSWORD shutdown
fi

exec mysqld_safe
