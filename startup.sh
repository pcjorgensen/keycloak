#!/bin/bash
setenv PASSWORD=`cat /secret-volume/password`
./bin/add-user-keycloak.sh --user admin --password $PASSWORD --realm master
chmod 0700 /secret-volume