FROM alpine:3.21

# تحديث المتغير إلى النسخة الأخيرة v26.10.10
ARG XRAY_VERSION=26.10.10

RUN apk add --no-cache \
    ca-certificates \
    curl \
    unzip \
    tzdata

RUN set -eux; \
    curl -fsSL \
      "https://github.com{XRAY_VERSION}/Xray-linux-64.zip" \
      -o /tmp/xray.zip; \
    # فك الضغط في مجلد مؤقت لتفادي مشاكل حالة الأحرف (Case Sensitivity)
    unzip /tmp/xray.zip -d /tmp/xray-extracted; \
    # نقل الملف التنفيذي الصحيح بأحرف صغيرة
    mv /tmp/xray-extracted/xray /usr/local/bin/; \
    # نقل ملفات التوجيه الجغرافي (ضرورية جداً إذا كنت تستخدم حظر أو توجيه المواقع)
    mv /tmp/xray-extracted/*.dat /usr/local/bin/ || true; \
    chmod +x /usr/local/bin/xray; \
    rm -rf /tmp/xray.zip /tmp/xray-extracted

WORKDIR /etc/xray

COPY config.json /etc/xray/config.json

EXPOSE 8080

CMD ["/usr/local/bin/xray", "run", "-config", "/etc/xray/config.json"]
