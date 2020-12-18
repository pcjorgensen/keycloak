FROM centos:7

RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y supervisor centos-release-scl subscription-manager wget && \
    yum install -y httpd && \
    yum clean all
RUN yum install openssl -y

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
RUN yum -y install java-1.8.0-openjdk-devel

RUN /opt/keycloak-4.8.3.Final/bin/add-user-keycloak.sh --user admin --password KEYCLOAKPASS --realm master
RUN /opt/keycloak-4.8.3.Final/bin/jboss-cli.sh 'embed-server,/subsystem=undertow/server=default-server/http-listener=default:write-attribute(name=proxy-address-forwarding,value=true)'
RUN /opt/keycloak-4.8.3.Final/bin/jboss-cli.sh 'embed-server,/socket-binding-group=standard-sockets/socket-binding=proxy-https:add(port=8443)'
RUN /opt/keycloak-4.8.3.Final/bin/jboss-cli.sh 'embed-server,/subsystem=undertow/server=default-server/http-listener=default:write-attribute(name=redirect-socket,value=proxy-https)'

ADD vhost.conf /etc/httpd/conf.d/vhost.conf
ADD supervisord.conf /etc/supervisord.conf

CMD ["/bin/sh", "-c", "/usr/bin/supervisord -c /etc/supervisord.conf"]