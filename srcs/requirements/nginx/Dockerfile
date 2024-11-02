# alpine:3.19.4
FROM alpine@sha256:f11993ab46a7e9f2d09007f8b7cbcc75e48e3691f9ae8d579fe4cb988d7b4ccd AS generate-cert

RUN apk update && apk add --no-cache openssl

RUN mkdir /var/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:5048 \
    -keyout /var/ssl/nginx-selfsigned.key \
    -out /var/ssl/nginx-selfsigned.crt \
    -subj "/C=FR/ST=SM/L=LH/O=42/OU=42LH/CN=liguyon.42.fr"

# Just for the eval. We don't intend keeping the cert 365d+, so no need to regenenerate.
# plus, it's self signed...
FROM alpine@sha256:f11993ab46a7e9f2d09007f8b7cbcc75e48e3691f9ae8d579fe4cb988d7b4ccd

RUN mkdir -p /etc/ssl/private /etc/ssl/certs
COPY --from=generate-cert /var/ssl/nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key
COPY --from=generate-cert /var/ssl/nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt

RUN apk update && apt add --no-cache nginx

EXPOSE 443

RUN mkdir /var/www/html
RUN chown -R nginx:www-data /var/www/html

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/http.d/default.conf
COPY ./conf/inception.conf /etc/nginx/http.d/inception.conf

ENTRYPOINT [ "nginx" ]
CMD ["-g", "daemon off;"]
