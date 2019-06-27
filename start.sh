#!/bin/bash
MAINCF=${MAINCF:-/etc/postfix/main.cf}
ALIASES=${ALIASES:-/etc/aliases}
sed -i "s#%%mailname%%#${MAILNAME:-localhost}#" /etc/postfix/main.cf
sed -i "s#%%relayhost%%#${RELAYHOST:-}#" /etc/postfix/main.cf
sed -i "s#%%mynetwork%%#${MYNETWORK:-172.16.0.0/12}#" /etc/postfix/main.cf
sed -i "s#^myhostname =.*\$#myhostname = ${MYHOSTNAME:-localhost.localdomain}#" /etc/postfix/main.cf
sed -i "s#%%rootaddress%%#${ROOTADDRESS:-root@localhost}#" /etc/aliases
newaliases
/usr/sbin/rsyslogd
sleep 3
/usr/sbin/postfix start
exec tail -f /var/log/syslog
