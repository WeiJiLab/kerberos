# kerberos

## Build
```bash
$ docker build -t kerberos .
```

## Ports
|Port|Description|
|---|---|
|88|KDC Server|
|749|KDC Admin Server|

## Volumes
For running this docker, following volumes need be mounted
* /etc/krb5.conf
* /var/lib/krb5kdc/kdc.conf
* /opt/krb5/kadm5.acl
* /opt/keytabs
* /usr/local/bin/init.sh