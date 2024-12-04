FROM golang:alpine AS builder

COPY ptool /ptool

RUN cd /ptool && go build -o ptool

FROM alpine:latest

WORKDIR /app

COPY --from=builder /ptool/ptool /usr/bin/ptool

COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache bash

RUN chmod +x /usr/bin/ptool /entrypoint.sh && mkdir -p /config

RUN echo "*/5 * * * * bash /config/brush.sh >> /var/log/cron.log 2>&1" > /etc/crontabs/root

VOLUME [ "/config" ]

ENTRYPOINT ["/entrypoint.sh"]
