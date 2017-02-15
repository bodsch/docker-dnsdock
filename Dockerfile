
FROM alpine:latest

MAINTAINER Bodo Schulz <bodo@boone-schulz.de>

LABEL version="1702-02"

ENV \
  ALPINE_MIRROR="dl-cdn.alpinelinux.org" \
  ALPINE_VERSION="v3.5" \
  TERM=xterm \
  GOPATH=/opt/go \
  GO15VENDOREXPERIMENT=0

EXPOSE 53 53/udp 80

# ---------------------------------------------------------------------------------------

RUN \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/main"       > /etc/apk/repositories && \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/community" >> /etc/apk/repositories && \
  apk --quiet --no-cache update && \
  apk --quiet --no-cache upgrade && \
  apk --quiet --no-cache add \
    build-base \
    drill \
    go \
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
    bash \
    build-base \
    go \
    git \
    nano \
    tree \
    curl \
    ca-certificates \
    supervisor && \
  rm -rf \
    ${GOPATH} \
    /tmp/* \
    /var/cache/apk/*

ENTRYPOINT [ "/usr/bin/dnsdock" ]

# ---------------------------------------------------------------------------------------
