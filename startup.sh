#!/bin/bash
chmod 700 standalone
export PASSWORD=`cat /secret-volume/password`
./bin/add-user-keycloak.sh --user admin --password $PASSWORD --realm master
yum -y install java-1.8.0-openjdk-devel
./bin/jboss-cli.sh 'embed-server,/subsystem=undertow/server=default-server/http-listener=default:write-attribute(name=proxy-address-forwarding,value=true)'
./bin/jboss-cli.sh 'embed-server,/socket-binding-group=standard-sockets/socket-binding=proxy-https:add(port=8443)'
./bin/jboss-cli.sh 'embed-server,/subsystem=undertow/server=default-server/http-listener=default:write-attribute(name=redirect-socket,value=proxy-https)'