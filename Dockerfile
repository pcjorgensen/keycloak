FROM jboss/keycloak
RUN yum install -y coreutils
CMD ["-b" "0.0.0.0"]