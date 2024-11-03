FROM alpine@sha256:f11993ab46a7e9f2d09007f8b7cbcc75e48e3691f9ae8d579fe4cb988d7b4ccd

# php 8.2 penultimate version
RUN apk update && apk add --no-cache \
    curl \
    mariadb-client \
    # php82 php82-fpm php82-phar php82-curl php82-mbstring php82-json php82-mysqli
    php82 php82-fpm php82-bcmath php82-bz2 php82-calendar php82-cli php82-ctype \
			php82-curl php82-dom php82-exif php82-fileinfo php82-gd php82-gmp \
			php82-iconv php82-imap php82-intl php82-json php82-mbstring \
			php82-mysqli php82-mysqlnd php82-openssl php82-pcntl php82-pdo php82-pdo_mysql \
			php82-pdo_pgsql php82-pdo_sqlite php82-pgsql php82-phar php82-posix php82-session \
			php82-shmop php82-simplexml php82-soap php82-sockets php82-sodium php82-sqlite3 \
			php82-sysvsem php82-sysvshm php82-tokenizer php82-xml php82-xmlreader php82-xmlwriter \
			php82-xsl php82-zip php82-zlib

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html

RUN	sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php82/php-fpm.d/www.conf

COPY ./tools/configure.sh /usr/bin/configure-wp.sh

WORKDIR /var/www/html

ENTRYPOINT [ "sh" ]
CMD [ "/usr/bin/configure-wp.sh" ]
