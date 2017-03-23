
FROM golang:1.8-alpine
#FROM alpine:latest

MAINTAINER Bodo Schulz <bodo@boone-schulz.de>

LABEL version="1703-03"

ENV \
  ALPINE_MIRROR="dl-cdn.alpinelinux.org" \
  ALPINE_VERSION="v3.5" \
  TERM=xterm \
  GOPATH=/opt/go \
  GO15VENDOREXPERIMENT=0

EXPOSE 53 53/udp 80

# ---------------------------------------------------------------------------------------

RUN \
  apk --quiet --no-cache update && \
  apk --quiet --no-cache upgrade && \
  apk --quiet --no-cache add \
    build-base \
    drill \
    git && \
  mkdir -p ${GOPATH} && \
  export PATH="${PATH}:${GOPATH}/bin" && \
  go get github.com/tools/godep && \
  go get github.com/aacebedo/dnsdock || true && \
  cd ${GOPATH}/src/github.com/aacebedo/dnsdock && \
  godep restore && \
  cd ${GOPATH}/src/github.com/aacebedo/dnsdock/src && \
  go build -o /usr/bin/dnsdock && \
  apk del --purge \
    build-base \
    git && \
  rm -rf \
    ${GOPATH} \
    /go \
    /tmp/* \
    /usr/local/go \
    /usr/local/bin/go-wrapper \
    /var/cache/apk/*

WORKDIR /

ENTRYPOINT [ "/usr/bin/dnsdock" ]

# ---------------------------------------------------------------------------------------
