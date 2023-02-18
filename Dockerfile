# syntax=docker/dockerfile:1
FROM golang:1.18-alpine3.17 AS builder

WORKDIR /build

RUN apk add --no-cache \
    make \
    git \
    ca-certificates

ENV DOCKER_BUILD=true, CGO_ENABLED=0
ENV GOPRIVATE=github.com/eurofurence/*

ARG VERSION="v0.0.1"

COPY . /build/

RUN make build 

FROM alpine:3.17.2
RUN apk add --no-cache ca-certificates

WORKDIR /app

COPY --from=builder /build/service /app/service

EXPOSE 8080

ENTRYPOINT [ "/app/service" ]

