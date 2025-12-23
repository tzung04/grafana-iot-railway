FROM grafana/grafana:latest
# Tạo thư mục provisioning
RUN mkdir -p /etc/grafana/provisioning/datasources \
    /etc/grafana/provisioning/dashboards \
    /var/lib/grafana/dashboards

# Copy provisioning configs
COPY provisioning/datasources/*.yaml /etc/grafana/provisioning/datasources/
COPY provisioning/dashboards/*.yaml /etc/grafana/provisioning/dashboards/

# Copy dashboard JSON files
COPY dashboards/*.json /var/lib/grafana/dashboards/

# BẬT ANONYMOUS MODE - có thể embed được
ENV GF_SECURITY_ALLOW_EMBEDDING=true
# ENV GF_AUTH_ANONYMOUS_ENABLED=true
# ENV GF_AUTH_ANONYMOUS_ORG_ROLE=Viewer
ENV GF_SECURITY_COOKIE_SAMESITE=none
ENV GF_SECURITY_COOKIE_SECURE=true
ENV GF_SERVER_ENABLE_GZIP=true

# Vẫn giữ admin để quản lý khi cần
ENV GF_SECURITY_ADMIN_PASSWORD=${ADMIN_PASSWORD}

USER grafana