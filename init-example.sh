#!/bin/sh

REALM='EXAMPLE.COM'
PRINCIPALS='tom/cat@EXAMPLE.COM:12345678 jerry/mouse@EXAMPLE.COM:12345678 john@EXAMPLE.COM:12345678'

kdb5_util create -r "${REALM}" -s -P SuperSecretPassword
kadmin.local -q "add_principal -randkey adminuser/admin"

for pp in ${PRINCIPALS}; do
    principal=$(echo ${pp} | awk -F: '{print $1}')
    password=$(echo ${pp} | awk -F: '{print $2}')

    account=$(echo ${principal} | sed -e 's/@/:/g' | awk -F: '{print $1}')
    realm=$(echo ${principal} | sed -e 's/@/:/g' | awk -F: '{print $2}')

    username=$(echo ${account} | awk -F/ '{print $1}')
    entity=$(echo ${account} | awk -F/ '{print $2}')

    if [ -n "$password" ]; then
      kadmin.local -q "add_principal -pw $password $account"
    else
      kadmin.local -q "add_principal -randkey $account"
    fi

    if [ ! -d "${KEYTABS_FOLDER}/${entity}" ]; then
        mkdir -p "${KEYTABS_FOLDER}/${entity}"
    fi
    kadmin.local -q "ktadd -norandkey -k ${KEYTABS_FOLDER}/${entity}/$username.keytab $account"
done
