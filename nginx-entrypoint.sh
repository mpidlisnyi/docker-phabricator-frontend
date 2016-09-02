#!/bin/bash
[ "${SSL_CERTIFICATE}" ] && [ "${SSL_CERTIFICATE_KEY}" ] || [ -f /etc/nginx/custom_cert.key ] || openssl req -x509 -new -newkey rsa:2048 -nodes -days 3650 -out /etc/nginx/custom_cert.pem -keyout /etc/nginx/custom_cert.key -config /openssl_for_selfsigned_cert.cnf &>/dev/null
erb -T - /nginx.conf.erb > /etc/nginx/nginx.conf
exec ${@}
