FROM alpine:3.21

RUN apk add --no-cache ca-certificates wget unzip tzdata

RUN wget -O /tmp/xray.zip https://github.com

RUN unzip /tmp/xray.zip -d /tmp/xray-extracted

RUN mv /tmp/xray-extracted/xray /usr/local/bin/xray

RUN chmod +x /usr/local/bin/xray

RUN rm -rf /tmp/xray.zip /tmp/xray-extracted

WORKDIR /etc/xray

COPY config.json /etc/xray/config.json

EXPOSE 8080

CMD ["/usr/local/bin/xray", "run", "-config", "/etc/xray/config.json"]
