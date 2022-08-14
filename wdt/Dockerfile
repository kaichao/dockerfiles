FROM debian:11

LABEL maintainer="kaichao"

RUN apt-get update \
    && apt-get install -y cmake g++ libboost-all-dev make git libssl-dev libgtest-dev \
        libgoogle-glog-dev libboost-system-dev libdouble-conversion-dev \
        libunwind8-dev libjemalloc-dev libfmt-dev
RUN git clone https://github.com/facebook/wdt.git \
    && git clone https://github.com/facebook/folly.git

RUN cd wdt && cmake -DCMAKE_INSTALL_PREFIX=/install . && make -j 20 && make install

FROM debian:11-slim

RUN apt-get update \
    && apt-get install -y libgoogle-glog-dev libdouble-conversion-dev \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=0 /install /usr/local/

ENV LD_LIBRARY_PATH=/usr/local/lib
