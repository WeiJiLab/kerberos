FROM alpine

ENV KEYTABS_FOLDER /opt/keytabs

VOLUME [ "${KEYTABS_FOLDER}" ]

RUN apk add --update krb5-server

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 744 /usr/local/bin/entrypoint.sh

EXPOSE 88 749
ENTRYPOINT /usr/local/bin/entrypoint.sh