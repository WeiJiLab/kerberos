FROM alpine

ENV KEYTABS_FOLDER /opt/keytabs
ENV LOGS_FOLDER /var/log/kerberos

VOLUME [ \
    "${KEYTABS_FOLDER}", \
    "${LOGS_FOLDER}" \
    ]

RUN apk add --update krb5-server

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 744 /usr/local/bin/entrypoint.sh

EXPOSE 88 749
ENTRYPOINT /usr/local/bin/entrypoint.sh