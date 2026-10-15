FROM alpine:3.21

RUN apk add --no-cache ca-certificates wget unzip tzdata

WORKDIR /tmp

RUN wget https://github.com

RUN unzip Xray-linux-64.zip

RUN mv xray /usr/local/bin/xray

RUN chmod +x /usr/local/bin/xray

RUN rm -rf /tmp/*

WORKDIR /etc/xray

COPY config.json /etc/xray/config.json

EXPOSE 8080

CMD ["/usr/local/bin/xray", "run", "-config", "/etc/xray/config.json"]
