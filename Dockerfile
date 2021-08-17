FROM jboss/keycloak:4.8.3.Final
RUN yum install -y coreutils
CMD ["/bin/bash", "-c", "/etc/keycloak/keycloak-setup.sh"]