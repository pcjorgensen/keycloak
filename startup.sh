#!/bin/bash
chmod 700 standalone
export PASSWORD=`cat /secret-volume/password`
/opt/keycloak-4.8.3.Final/bin/add-user-keycloak.sh --user admin --password $PASSWORD --realm master
/opt/keycloak-4.8.3.Final/bin/jboss-cli.sh 'embed-server,/subsystem=undertow/server=default-server/http-listener=default:write-attribute(name=proxy-address-forwarding,value=true)'
/opt/keycloak-4.8.3.Final/bin/jboss-cli.sh 'embed-server,/socket-binding-group=standard-sockets/socket-binding=proxy-https:add(port=8443)'
/opt/keycloak-4.8.3.Final/bin/jboss-cli.sh 'embed-server,/subsystem=undertow/server=default-server/http-listener=default:write-attribute(name=redirect-socket,value=proxy-https)'