FROM bodsch/docker-golang:1.8

MAINTAINER Bodo Schulz <bodo@boone-schulz.de>

LABEL version="1705-01"

ENV \
  ALPINE_MIRROR="dl-cdn.alpinelinux.org" \
  ALPINE_VERSION="edge" \
  TERM=xterm \
  BUILD_DATE="2017-05-01" \
  DNSDOCK_VERSION="1.16.4" \
  GOPATH=/opt/go \
  GO15VENDOREXPERIMENT=0

EXPOSE 53 53/udp 80

LABEL org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.name="dnsdock Docker Image" \
      org.label-schema.description="Inofficial dnsdock Docker Image" \
      org.label-schema.url="https://github.com/aacebedo/dnsdock" \
      org.label-schema.vcs-url="https://github.com/bodsch/docker-dnsdock" \
      org.label-schema.vendor="Bodo Schulz" \
      org.label-schema.version=${DNSDOCK_VERSION} \
      org.label-schema.schema-version="1.0" \
      com.microscaling.docker.dockerfile="/Dockerfile" \
      com.microscaling.license="GNU General Public License v3.0"

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
  git describe --contains HEAD && \
  go build -o /usr/bin/dnsdock && \
  apk del --purge \
    build-base \
    git && \
  rm -rf \
    ${GOPATH} \
    /usr/lib/go \
    /usr/bin/go \
    /usr/bin/gofmt \
    /tmp/* \
    /var/cache/apk/*

WORKDIR /

ENTRYPOINT [ "/usr/bin/dnsdock" ]

# ---------------------------------------------------------------------------------------
