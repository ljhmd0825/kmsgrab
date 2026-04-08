FROM ubuntu:22.04

RUN dpkg --add-architecture arm64 && \
    sed -i 's/archive.ubuntu.com/ports.ubuntu.com/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/ports.ubuntu.com/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y \
    gcc-aarch64-linux-gnu \
    pkg-config \
    libdrm-dev:arm64 \
    libpng-dev:arm64 \
    zlib1g-dev:arm64 \
    && rm -rf /var/lib/apt/lists/*

ENV PKG_CONFIG_PATH=/usr/lib/aarch64-linux-gnu/pkgconfig
WORKDIR /build
