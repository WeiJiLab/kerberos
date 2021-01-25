#!/bin/sh

if [ -f "/usr/local/bin/init.sh" ]; then
    chmod 744 /usr/local/bin/init.sh

    KRB5_INIT_DONE='/etc/krb5_init.done'
    if [ ! -f "${KRB5_INIT_DONE}" ]; then
        /usr/local/bin/init.sh
        if [ $? -eq 0 ]; then
            touch "${KRB5_INIT_DONE}"
        fi
    fi
fi

kadmind
krb5kdc -n