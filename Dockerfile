FROM jboss/keycloak
RUN yum install -y coreutils
CMD ["/bin/bash", "-c", "/etc/keycloak/keycloak-setup.sh"]