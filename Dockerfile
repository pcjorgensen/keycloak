FROM jboss/keycloak:4.8.3.Final
USER root
RUN yum install -y coreutils
CMD ["/opt/keycloak-setup.sh"]