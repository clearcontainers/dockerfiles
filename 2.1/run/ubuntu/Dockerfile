#
#  Copyright (C) 2016 Intel Corporation
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

FROM ubuntu:16.04

# Ensure packages are current, then install dependencies
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y vim procps wget libmnl0

# Add the OBS repository
RUN sh -c "echo 'deb http://download.opensuse.org/repositories/home:/clearlinux:/preview:/clear-containers-2.0/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/cc-oci-runtime.list"

# Install OBS key
RUN wget http://download.opensuse.org/repositories/home:clearlinux:preview:clear-containers-2.0/xUbuntu_16.04/Release.key
RUN apt-key add Release.key
RUN rm Release.key

# Install the Clear Containers assets.
# Note that the command below installs (a version of) the runtime. This
# version isn't used (since this docker image after all is for testing
# development versions of the runtime). However, specifying the runtime
# package ensures the Clear Containers assets are installed
# automatically as dependencies of the runtime package.
RUN apt-get update
RUN apt-get install -y cc-oci-runtime

# Install Docker 1.12.1
# Note that currently cc-oci-runtime only works with Docker 1.12.1 as it
# only supports OCI specification 1.0.0-rc1
# More info can be found at https://github.com/01org/cc-oci-runtime/issues/275
RUN apt-get update
RUN apt-get install -y apt-transport-https ca-certificates
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN sh -c "echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' >> /etc/apt/sources.list.d/docker.list"
RUN apt-get update
RUN apt-get purge lxc-docker
RUN apt-cache policy docker-engine
RUN apt-get install -y docker-engine=1.12.1-0~xenial

# Have Docker run with Clear Containers as the default runtime
RUN echo "#!/bin/bash\ndockerd --add-runtime cor=/usr/bin/cc-oci-runtime --default-runtime=cor --storage-driver=vfs > /dev/null 2>&1 &" > /root/start-cc.sh && chmod +x /root/start-cc.sh

ENV HOME /root
WORKDIR $HOME

# Use Clear Containers by default
CMD bash -C '/root/start-cc.sh';'bash'
