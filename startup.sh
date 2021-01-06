#!/bin/bash
export PASSWORD=`cat /secret-volume/password`
/opt/keycloak-4.8.3.Final/bin/add-user-keycloak.sh --user admin --password $PASSWORD --realm master
chmod 0700 /secret-volume && chmod 0700 /secret-volume/password