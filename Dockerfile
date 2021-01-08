FROM jboss/keycloak

RUN microdnf update -y && \
    microdnf install -y epel-release && \
    microdnf install -y supervisor centos-release-scl subscription-manager wget && \
    microdnf install -y httpd && \
    microdnf clean all
RUN microdnf install openssl -y

WORKDIR /opt
RUN wget https://downloads.jboss.org/keycloak/4.8.3.Final/keycloak-4.8.3.Final.tar.gz && \
    tar xzf keycloak-4.8.3.Final.tar.gz && \
    groupadd -r keycloak && \
    useradd -m -d /var/lib/keycloak -s /sbin/nologin -r -g keycloak keycloak && \
    chown keycloak: -R keycloak-4.8.3.Final

WORKDIR /opt/keycloak-4.8.3.Final
COPY startup.sh /opt/keycloak-4.8.3.Final/startup.sh
RUN chmod 0700 standalone
RUN chmod 0700 /opt/keycloak-4.8.3.Final/startup.sh
RUN microdnf -y install java-1.8.0-openjdk-devel

RUN /opt/keycloak-4.8.3.Final/bin/jboss-cli.sh 'embed-server,/subsystem=undertow/server=default-server/http-listener=default:write-attribute(name=proxy-address-forwarding,value=true)'
RUN /opt/keycloak-4.8.3.Final/bin/jboss-cli.sh 'embed-server,/socket-binding-group=standard-sockets/socket-binding=proxy-https:add(port=8443)'
RUN /opt/keycloak-4.8.3.Final/bin/jboss-cli.sh 'embed-server,/subsystem=undertow/server=default-server/http-listener=default:write-attribute(name=redirect-socket,value=proxy-https)'

ADD vhost.conf /etc/httpd/conf.d/vhost.conf
ADD supervisord.conf /etc/supervisord.conf

CMD ["/bin/sh", "-c", "/usr/bin/supervisord -c /etc/supervisord.conf"]