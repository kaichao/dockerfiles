FROM ubuntu:18.04
LABEL maintainer=peng.sun@amd.com
LABEL maintainer=wukaichao@gmail.com

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        libnuma-dev \
        gnupg \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        sudo \
        libelf1 \
        kmod \
        file \
        python3 \
        python3-pip \
        # rocm-dev \
        build-essential \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Register the ROCM package repository, and install rocm-dev package
ARG ROCM_VERSION=4.0.1
RUN apt-get update \
    && curl -sL https://repo.radeon.com/rocm/rocm.gpg.key | apt-key add - \
    && printf "deb [arch=amd64] http://repo.radeon.com/rocm/apt/$ROCM_VERSION/ xenial main" | tee /etc/apt/sources.list.d/rocm.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        rocm-device-libs \
        rocm-smi \
        rocm-utils \
        rocm-smi-lib64 \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV \
    PATH=/opt/rocm-4.0.1/bin:$PATH \
    LD_LIBRARY_PATH=/opt/rocm-4.0.1/lib:$LD_LIBRARY_PATH
