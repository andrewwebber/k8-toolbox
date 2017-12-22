FROM alpine:3.4

RUN apk --update add wget ca-certificates openssl && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/bin/ash"]
