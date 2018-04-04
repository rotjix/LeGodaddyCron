#!/bin/bash

echo ${DOMAINS} > dehydrated/domains.txt
printf "CA=\"https://acme-staging-v02.api.letsencrypt.org/directory\" \nCERTDIR=\"${PWD}/certs\"" > dehydrated/config

dehydrated/dehydrated --register --accept-terms
dehydrated/dehydrated --challenge dns-01 -k le-godaddy-dns/godaddy.py -c

certpath="$(find $PWD/certs -name cert.pem)"
pkpath="$(find $PWD/certs -name privkey.pem)"

php ssldeploy.php $certpath $pkpath
