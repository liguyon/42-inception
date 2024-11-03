#!/usr/bin/env sh

while ! mariadb -hmariadb -u${SQL_USER} -p${SQL_PASSWORD} ${SQL_DATABASE} &>/dev/null;
do
    echo "[info] Waiting for MariaDb."
    sleep 2
done

echo "[info] MariaDb up"

if [ ! -f "/var/www/html/wp-config.php" ];
then
    echo "[info] Begin WordPress installation."
    wp core download --allow-root
    wp config create \
        --dbhost=mariadb \
        --dbname=${SQL_DATABASE} \
        --dbuser=${SQL_USER} \
        --dbpass=${SQL_PASSWORD} \
        --allow-root
    if [ $? -eq 0 ]
    then
        echo "[info] WordPress config created."
    else
        echo "[error] WordPress config failed."
        exit 1
    fi
    wp core install \
        --url="liguyon.42.fr" \
        --title=${WP_TITLE} \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root
    if [ $? -eq 0 ]
    then
        echo "[info] WordPress core installed."
    else
        echo "[error] WordPress core installation failed."
        exit 1
    fi
    wp user create \
        --porcelain \
        --role=author \
        ${WP_AUTHOR_USER} \
        ${WP_AUTHOR_EMAIL} \
        --user_pass=${WP_AUTHOR_PASSWORD} \
        --allow-root
    if [ $? -eq 0 ]
    then
        echo "[info] WordPress author user created."
    else
        echo "[error] WordPress author user creation failed."
        exit 1
    fi
fi

echo "[info] WordPress is installed. Starting WorPress."

exec php-fpm82 -FR
