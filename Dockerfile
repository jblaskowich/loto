FROM golang:1.13.7-stretch as builder

COPY main.go .

ADD https://github.com/upx/upx/releases/download/v3.95/upx-3.95-amd64_linux.tar.xz /usr/local

RUN set -x && \
    apt update && apt install -y xz-utils && \
    xz -d -c /usr/local/upx-3.95-amd64_linux.tar.xz | \
    tar -xOf - upx-3.95-amd64_linux/upx > /bin/upx && \
    chmod a+x /bin/upx && \
    go get -d -v . && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o /app . && \
    strip --strip-unneeded /app && \
    upx /app

FROM scratch
CMD ["/app"]
COPY --from=builder /app /