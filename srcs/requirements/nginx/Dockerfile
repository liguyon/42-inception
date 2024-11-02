# alpine:3.19.4
FROM alpine@sha256:f11993ab46a7e9f2d09007f8b7cbcc75e48e3691f9ae8d579fe4cb988d7b4ccd

RUN apk update && apk upgrade

RUN apk add --no-cache nginx
RUN apk add --no-cache openssl

RUN mkdir -p /etc/ssl/private
RUN mkdir -p /etc/ssl/certs

RUN openssl req -x509 -nodes -days 365 -newkey rsa:5048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/nginx-selfsigned.crt \
    -subj "/C=FR/ST=SM/L=LH/O=42/OU=42LH/CN=liguyon.42.fr"

EXPOSE 80

RUN mkdir /var/www/html
COPY ./test.html /var/www/html
RUN chown -R nginx:www-data /var/www/html

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/http.d/default.conf
COPY ./conf/inception.conf /etc/nginx/http.d/inception.conf

CMD ["nginx", "-g", "daemon off;"]
