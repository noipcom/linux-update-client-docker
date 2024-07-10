FROM rust:1.79-slim-bookworm as builder
LABEL org.opencontainers.image.authors="No-IP Team <support@noip.com>"
LABEL org.opencontainers.image.source="https://github.com/noipcom/linux-update-client-docker"
LABEL org.opencontainers.image.description="Update Client for No-IP's Dynamic DNS service"

ARG VERSION=3.2.0
ARG TARGETARCH

RUN apt update \
 && apt install -y ca-certificates wget \
 && wget https://dmej8g5cpdyqd.cloudfront.net/downloads/noip-duc_${VERSION}.tar.gz \
 && tar xzf noip-duc_${VERSION}.tar.gz -C /tmp/ \
 && rm noip-duc_${VERSION}.tar.gz \
 && rm -rf /var/lib/apt/lists/* 

WORKDIR /tmp/noip-duc_${VERSION} 

RUN cargo build --release

FROM debian:bookworm-slim
ARG VERSION=3.2.0

RUN apt update \
 && apt install -y ca-certificates \
 && rm -rf /var/lib/apt/lists/*

COPY --from=builder /tmp/noip-duc_${VERSION}/target/release/noip-duc /usr/bin

ENTRYPOINT ["/usr/bin/noip-duc"]