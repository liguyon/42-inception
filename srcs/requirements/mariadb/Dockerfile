FROM alpine@sha256:f11993ab46a7e9f2d09007f8b7cbcc75e48e3691f9ae8d579fe4cb988d7b4ccd

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/configure.sh /usr/bin/configure-mariadb.sh

ENTRYPOINT [ "sh" ]
CMD [ "/usr/bin/configure-mariadb.sh" ]
