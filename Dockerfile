FROM ubuntu:14.04

ENV LMOD_VER 6.0.17
MAINTAINER Robert Schmidt <rjeschmi@gmail.com>

#RUN yum -y install git tar which bzip2 xz \
#            epel-release make automake gcc gcc-c++ patch \
#            python-keyring zlib-devel openssl-devel unzip
RUN apt-get -y update
RUN apt-get -y install curl build-essential

RUN mkdir -p /build
WORKDIR /build
RUN curl -LO http://github.com/TACC/Lmod/archive/${LMOD_VER}.tar.gz
RUN mv /build/${LMOD_VER}.tar.gz /build/Lmod-${LMOD_VER}.tar.gz
RUN tar xvf Lmod-${LMOD_VER}.tar.gz

WORKDIR /build/Lmod-${LMOD_VER}

RUN apt-get install -y lua5.2 liblua5.2-dev lua-posix-dev lua-filesystem-dev tcl

RUN apt-get install -y rsync

RUN ./configure --prefix=/software/Lmod
RUN make install
RUN ln -s /software/Lmod/lmod/lmod/init/profile /etc/profile.d/modules.sh
RUN ln -s /software/Lmod/lmod/lmod/init/cshrc /etc/profile.d/modules.csh

CMD /bin/bash

