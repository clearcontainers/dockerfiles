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

# XXX: named version (also referenced below for the OBS elements)
FROM ubuntu:16.04

# Ensure packages are current, then install dependencies
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y \
		build-essential \
		python zlib1g-dev \
		libcap-ng-dev \
		libglib2.0-dev \
		libattr1-dev \
		libcap-dev \
		autoconf \
		libtool \
		libjson-glib-dev \
		uuid-dev \
		check \
		bats \
		libdevmapper-dev \
		file \
		apt-utils \
		libmnl-dev \
		wget \
		git

# Install golang
RUN wget https://storage.googleapis.com/golang/go1.7.5.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.7.5.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
RUN rm go1.7.5.linux-amd64.tar.gz

# Set $GOPATH and $HOME env variables
RUN mkdir -p /root/go
ENV GOPATH /root/go
ENV HOME /root
WORKDIR $HOME

# Clone and clone cc-oci-runtime
RUN go get github.com/01org/cc-oci-runtime || exit 0
RUN cd $HOME/go/src/github.com/01org/cc-oci-runtime && \
    ./autogen.sh \
         --with-qemu-path=/usr/bin/qemu-lite-system-x86_64 \
         --with-cc-image=/usr/share/clear-containers/clear-containers.img \
         --with-cc-kernel=/usr/share/clear-containers/vmlinux.container
RUN cd $HOME/go/src/github.com/01org/cc-oci-runtime && \
    make

CMD ["/bin/bash"]
