FROM alpine:3.21

RUN apk add --no-cache ca-certificates curl unzip tzdata

RUN set -eux; \
    curl -fsSL "https://github.com" -o /tmp/xray.zip; \
    unzip /tmp/xray.zip -d /tmp/xray-extracted; \
    mv /tmp/xray-extracted/xray /usr/local/bin/; \
    mv /tmp/xray-extracted/*.dat /usr/local/bin/ || true; \
    chmod +x /usr/local/bin/xray; \
    rm -rf /tmp/xray.zip /tmp/xray-extracted

WORKDIR /etc/xray

COPY config.json /etc/xray/config.json

EXPOSE 8080

CMD ["/usr/local/bin/xray", "run", "-config", "/etc/xray/config.json"]
