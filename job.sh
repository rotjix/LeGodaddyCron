#!/bin/bash

## Default is testing environment authority, for production set ENV varriable to https://acme-v02.api.letsencrypt.org/directory
[[ -z "${CERTAUTH}" ]] && CERTAUTH="https://acme-staging-v02.api.letsencrypt.org/directory"

echo ${DOMAINS} > dehydrated/domains.txt
printf "CA=\"${CERTAUTH}\" \nCERTDIR=\"${PWD}/certs\" \nWELLKNOWN=\"${PWD}\"" > dehydrated/config

dehydrated/dehydrated --register --accept-terms
dehydrated/dehydrated --challenge dns-01 -k le-godaddy-dns/godaddy.py -c

certpath="$(find $PWD/certs -name cert.pem)"
pkpath="$(find $PWD/certs -name privkey.pem)"

php ssldeploy.php $certpath $pkpath
