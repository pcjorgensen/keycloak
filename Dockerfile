FROM jboss/keycloak
USER root
RUN yum install -y coreutils
CMD ["-b" "0.0.0.0"]