FROM alpine:3.21

ENV XRAY_VER=26.10.10
ENV XRAY_URL=https://github.com

RUN apk add --no-cache ca-certificates curl unzip tzdata

RUN curl -fsSL "${XRAY_URL}/v${XRAY_VER}/Xray-linux-64.zip" -o /tmp/xray.zip

RUN unzip /tmp/xray.zip -d /tmp/xray-extracted

RUN mv /tmp/xray-extracted/xray /usr/local/bin/xray

RUN chmod +x /usr/local/bin/xray

RUN rm -rf /tmp/xray.zip /tmp/xray-extracted

WORKDIR /etc/xray

COPY config.json /etc/xray/config.json

EXPOSE 8080

CMD ["/usr/local/bin/xray", "run", "-config", "/etc/xray/config.json"]
