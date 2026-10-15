FROM alpine:3.21

ARG XRAY_VERSION=26.10.10
ARG XRAY_FILE=Xray-linux-64.zip

RUN apk add --no-cache ca-certificates curl unzip tzdata

RUN set -eux; \
    curl -fsSL "https://github.com{XRAY_VERSION}/${XRAY_FILE}" -o /tmp/xray.zip; \
    unzip /tmp/xray.zip -d /tmp/xray-extracted; \
    mv /tmp/xray-extracted/xray /usr/local/bin/xray; \
    rm -rf /tmp/xray.zip /tmp/xray-extracted

WORKDIR /etc/xray

COPY config.json /etc/xray/config.json

EXPOSE 8080

CMD ["/usr/local/bin/xray", "run", "-config", "/etc/xray/config.json"]
