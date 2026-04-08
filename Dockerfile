FROM ubuntu:22.04

RUN dpkg --add-architecture arm64 && \
    # 1. 기존 sources.list에서 amd64만 보게 제한
    sed -i 's/deb http/deb [arch=amd64] http/g' /etc/apt/sources.list && \
    # 2. arm64 전용 ports 저장소 추가
    echo "deb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports jammy main restricted universe multiverse" > /etc/apt/sources.list.d/arm64.list && \
    echo "deb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports jammy-updates main restricted universe multiverse" >> /etc/apt/sources.list.d/arm64.list && \
    echo "deb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports jammy-security main restricted universe multiverse" >> /etc/apt/sources.list.d/arm64.list && \
    # 3. 업데이트 및 설치
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
