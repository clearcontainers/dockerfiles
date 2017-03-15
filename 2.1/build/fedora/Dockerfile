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
FROM fedora:24

# Disable deltarpms.
#
# See: https://bugzilla.redhat.com/show_bug.cgi?id=1343114)
RUN echo deltarpm=0 >> /etc/dnf/dnf.conf

# Ensure packages are current, then install:
#
# - a basic development environment
# - runtime build dependencies and additional general tooling
#
# (Note: python3-dnf-plugins-core is required for "dnf config-manager").
RUN dnf -y update && \
    dnf -y groups install "RPM Development Tools" && \
    dnf -y install \
    	@development-tools \
	autoconf \
	automake \
	bats \
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
	zlib-devel \
        wget \
	valgrind \
	cpan \
	htop procps-ng \
	file \
	gcc-c++ \ 
	bison \
	flex \
	numactl-devel \
	libtool \
	attr \ 
	pixman-devel \ 
	python-devel \
	zlib-devel \
	libcap-ng-devel \
	libcap-devel \
	libattr-devel

# Install Go
RUN wget https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.8.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

# Create a clear containers (cc) user
ENV USER cc
ENV HOME /home/cc
RUN useradd -u 1000 -U -d ${HOME} -s /bin/bash ${USER}

USER    ${USER}
WORKDIR ${HOME}

RUN mkdir -p /home/cc/go
ENV GOPATH /home/cc/go

RUN mkdir -p /home/cc/rpmbuild/SOURCES
COPY SOURCES/* /home/cc/rpmbuild/SOURCES/

CMD ["/bin/bash"]
