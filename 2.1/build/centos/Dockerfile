#  This file is part of cc-oci-runtime.
#
#  Copyright (C) 2017 Intel Corporation
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either version 2
#  of the License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#

# XXX: named version
FROM centos:7

# Disable deltarpms.
#
# See: https://bugzilla.redhat.com/show_bug.cgi?id=1343114)
RUN echo deltarpm=0 >> /etc/yum.conf

# Ensure packages are current, then install:
#
# - a basic development environment
# - runtime build dependencies and additional general tooling
#
RUN yum -y update && \
    yum -y group install "Development Tools" && \
    yum -y install \
    	autoconf \
	automake \
	check \
	check-devel \
	cppcheck \
	gettext-devel \
	glib2-devel \
	json-glib-devel \
	libffi-devel \
	libmnl-devel \
	libtool \
	libuuid-devel \
	pcre-devel \
	pkgconfig \
	python3-dnf-plugins-core \
	sudo \
	valgrind \
	wget \
	zlib-devel \
	cpan \
	htop procps-ng \
	file \
	libattr-devel \
	attr \
	libcap-devel \
	libcap-ng-devel \
	libtool-ltdl-devel \
	numactl-devel \
	python-devel \
	m4 \
	pixman-devel \
	bison \
	flex  

# Install BATS
RUN git clone https://github.com/sstephenson/bats
RUN cd bats && \
    ./install.sh /usr/local

# Install Glib & Json-Glib
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
RUN yum -y install zlib-devel
RUN curl -L -O "https://download.gnome.org/sources/glib/2.46/glib-2.46.2.tar.xz"
RUN tar -xvf glib-2.46.2.tar.xz
RUN pushd glib-2.46.2 && \
    ./configure --prefix=/usr --disable-silent-rules && make -j5 && \
    sudo make install && \
    popd
RUN curl -L -O "https://download.gnome.org/sources/json-glib/1.2/json-glib-1.2.2.tar.xz"
RUN tar -xvf json-glib-1.2.2.tar.xz
RUN pushd json-glib-1.2.2 && \
    ./configure --prefix=/usr --disable-silent-rules && make -j5 && \
    sudo make install && \
    popd

# Install updated GCC
RUN yum -y install gmp-devel mpfr-devel libmpc-devel gcc-c++
RUN curl -L -O http://www.mirrorservice.org/sites/ftp.gnu.org/gnu/gcc/gcc-6.2.0/gcc-6.2.0.tar.gz
RUN tar xvf gcc-6.2.0.tar.gz
RUN pushd gcc-6.2.0 && \
    ./configure --prefix=/usr --enable-languages=c --disable-multilib --prefix=/usr/local/gcc-6.2.0 && \
    make -j5 && sudo make install && \
    popd
ENV PATH=/usr/local/gcc-6.2.0/bin:$PATH

# Install Devtoolset
RUN yum -y install centos-release-scl
RUN yum -y install devtoolset-4

# Install Go
RUN wget https://storage.googleapis.com/golang/go1.7.5.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.7.5.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
RUN rm go1.7.5.linux-amd64.tar.gz

# Set $GOPATH and $HOME env variables
RUN mkdir -p /root/go
ENV GOPATH /root/go
ENV HOME /root
WORKDIR $HOME

CMD ["/bin/bash"]
