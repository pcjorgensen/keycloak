FROM jboss/keycloak:4.8.3.Final
USER root
RUN yum install -y coreutils
CMD ["/bin/bash", "-c", "/etc/keycloak/keycloak-setup.sh"]