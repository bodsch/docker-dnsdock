# docker-dnsdock

A Docker container for the DNS service discovery for Docker containers (https://github.com/aacebedo/dnsdock)


# Status

[![Docker Pulls](https://img.shields.io/docker/pulls/bodsch/docker-dnsdock.svg?branch)][hub]
[![Image Size](https://images.microbadger.com/badges/image/bodsch/docker-dnsdock.svg?branch)][microbadger]
[![Build Status](https://travis-ci.org/bodsch/docker-dnsdock.svg?branch)][travis]

[hub]: https://hub.docker.com/r/bodsch/docker-dnsdock/
[microbadger]: https://microbadger.com/images/bodsch/docker-dnsdock
[travis]: https://travis-ci.org/bodsch/docker-dnsdock


# Build

Your can use the included Makefile.

To build the Container: `make build`

Starts the Container: `make run`

Starts the Container with Login Shell: `make shell`

Entering the Container: `make exec`

Stop (but **not kill**): `make stop`

History `make history`


# Usage

Look at the `Makefile` for Examples. :)


# Docker Hub

You can find the Container also at  [DockerHub](https://hub.docker.com/r/bodsch/docker-dnsdock)

## get

    docker pull bodsch/docker-dnsdock


# Ports

  - 53
  - 53/udp
  - 80
