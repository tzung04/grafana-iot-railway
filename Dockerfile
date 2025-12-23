FROM grafana/grafana:latest

USER root

# Tạo thư mục provisioning
RUN mkdir -p /etc/grafana/provisioning/datasources \
    /etc/grafana/provisioning/dashboards \
    /var/lib/grafana/dashboards

# Copy provisioning configs
COPY provisioning/datasources/*.yaml /etc/grafana/provisioning/datasources/
COPY provisioning/dashboards/*.yaml /etc/grafana/provisioning/dashboards/

# Copy dashboard JSON files
COPY dashboards/*.json /var/lib/grafana/dashboards/

# Biến môi trường cho anonymous mode và embedding
ENV GF_SECURITY_ALLOW_EMBEDDING=true \
    GF_AUTH_ANONYMOUS_ENABLED=true \
    GF_AUTH_ANONYMOUS_ORG_ROLE=Viewer \
    GF_SECURITY_COOKIE_SAMESITE=none \
    GF_SECURITY_COOKIE_SECURE=true \
    GF_SERVER_ENABLE_GZIP=true \
    GF_AUTH_DISABLE_LOGIN_FORM=false

EXPOSE 3000


USER grafana
