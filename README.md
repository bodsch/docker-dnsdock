# docker-dnsdock

A Docker container for the DNS service discovery for Docker containers (https://github.com/aacebedo/dnsdock)


# Status

[![Build Status](https://travis-ci.org/bodsch/docker-dnsdock.svg?branch=master)](https://travis-ci.org/bodsch/docker-dnsdock)


# Build

Your can use the included Makefile.

To build the Container:
    make build

Starts the Container:
    make run

Starts the Container with Login Shell:
    make shell

Entering the Container:
    make exec

Stop (but **not kill**):
    make stop

History
    make history


# Docker Hub

You can find the Container also at  [DockerHub](https://hub.docker.com/r/bodsch/docker-dnsdock)

## get

    docker pull bodsch/docker-dnsdock


# supported Environment Vars

# Ports

 - 53
 - 53/udp

