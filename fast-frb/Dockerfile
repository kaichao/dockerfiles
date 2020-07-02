FROM nvidia/cuda:10.1-devel-centos7 as builder

LABEL maintainer="kaichao@cnic.cn"

# yum repolist all
RUN yum-config-manager --disable cuda
RUN yum install -y make csh autoconf automake libtool file hwloc-devel patch boost-devel which

# for psrchive
RUN yum install -y epel-release \
    && yum localinstall -y --nogpgcheck \
        https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm \
        https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
RUN yum install -y git gcc-gfortran gcc-g++ fftw-devel pgplot-devel

# for heimdall
RUN yum install -y centos-release-scl \
    && yum install -y devtoolset-8-gcc devtoolset-8-gcc-c++ 

COPY ./app /app

# RUN cd /app && git clone git://git.code.sf.net/p/psrchive/code psrchive
# Install psrchive
RUN cd /app/psrchive && ./bootstrap && ./configure \
    && cd packages && make && cd .. && ./packages/tempo2.csh && ./packages/cfitsio.csh \
    && TEMPO2=/root/software/psrchive/tempo2 ./configure \
    && make -j4 install

# # RUN cd /app && git clone git://git.code.sf.net/p/dspsr/code dspsr
# Install dspsr
RUN cd /app/dspsr && ./bootstrap && ./configure --prefix=$HOME/software/dspsr && make install

# RUN cd /app && git clone https://github.com/ajameson/dedisp.git
# RUN sed -i 's/sm_30/sm_60/g' /app/dedisp/Makefile.inc
# # Nvidia P100, GPU_ARCH ?= sm_60
RUN mkdir -p /$HOME/software/dedisp && cd /$HOME/software/dedisp/ && mkdir include lib \
    && cd /app/dedisp && make INSTALL_DIR=$HOME/software/dedisp install

# RUN cd /app && git clone https://git.code.sf.net/p/psrdada/code psrdada
RUN cd /app/psrdada && ./bootstrap && ./configure --prefix=$HOME/software/psrdada && make install

# RUN cd /app && git clone https://git.code.sf.net/p/heimdall-astro/code heimdall
RUN cd /app/heimdall && ./bootstrap \
    && ./configure --prefix=$HOME/software/heimdall --with-psrdada-dir=$HOME/software/psrdada \
    --with-dedisp-dir=$HOME/software/dedisp --with-cuda-dir=/usr/local/cuda \
    CFLAGS="-I/root/software/psrdada/include" CPPFLAGS="-I/root/software/psrdada/include"
# compiled by gcc8
RUN ["/bin/bash", "-c", "source scl_source enable devtoolset-8 && make -C /app/heimdall install"]

# copy to /app/prod, can be used by prod container
# RUN mkdir /app/prod && cd $HOME/software && cp -r heimdall/* dedisp/* psrdada/* /app/prod
RUN mkdir /app/prod && cd $HOME/software && cp -r heimdall/* dedisp/* psrdada/* dspsr/* /app/prod
RUN cp -r /app/prod/* /usr/local

# remove unused libraries and debugging info to reduce image size
RUN cd /app/prod/lib && rm -f lib*a lib*la && strip libdedisp.so.1.0.1 \
    && cd /app/prod/bin && strip heimdall

FROM nvidia/cuda:10.1-base-centos7 as app

LABEL maintainer="kaichao@cnic.cn"

RUN useradd --uid 1417 fast

COPY --from=0 /app/prod /usr/local/

ENV LANG en_US.utf8
ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH
ENV PATH /app/bin:/app/sbin:$PATH

COPY ROOT/ /

WORKDIR /data
USER fast

ENTRYPOINT ["sock-worker.sh"]

# param 1: script, python script for real processing
# param 2: gpu id
# CMD fifo-worker.sh start_huntting.py 1
