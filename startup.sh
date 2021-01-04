#!/bin/bash
export PASSWORD=`cat /secret-volume/password` && /opt/keycloak-4.8.3.Final/bin/add-user-keycloak.sh --user admin --password $PASSWORD --realm master
/opt/keycloak-4.8.3.Final/bin/jboss-cli.sh 'embed-server,/socket-binding-group=standard-sockets/socket-binding=proxy-https:add(port=8443)'
chmod 0700 /secret-volume && chmod 0700 /secret-volume/password
supervisorctl restart apache