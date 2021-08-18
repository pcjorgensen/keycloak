FROM jboss/keycloak:9.0.0
CMD ["/bin/sh", "-c", "/usr/bin/supervisord -c /etc/supervisord.conf"]