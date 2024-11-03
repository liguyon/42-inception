#!/usr/bin/env sh

if [ ! -d /var/lib/mysql/$SQL_DATABASE ]; then
  mysql_install_db
  /usr/share/mariadb/mysql.server start
  mysql -e "\
    DELETE FROM mysql.user WHERE User=''; \
    DROP DATABASE IF EXISTS test; \
    DELETE FROM mysql.db WHERE Db='test'; \
    CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE}; \
    CREATE USER '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}'; \
    GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%'; \
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}'; \
    FLUSH PRIVILEGES; \
    "
  mysqladmin --user=root --password=${SQL_ROOT_PASSWORD} shutdown
fi

exec mysqld_safe
