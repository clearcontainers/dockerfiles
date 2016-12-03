#
# Clear Linux Sandbox for Clear Containers
#
#
# Running this container
# sudo docker run --privileged -it clearcontainers/clearlinux
#
# The container needs to run as privileged in order to launch docker clear containers
#
# To run this container
#
# sudo docker run -it -e HTTP_PROXY="xxx" -e HTTPS_PROXY="xxx" --privileged clearcontainers/clearlinux
#
# To launch containers within this container
#
# 1. Launch the docker daemon
# ./run_dockerd
# 2. Launch a clear container
#  docker run -it debian

FROM clearlinux:latest

MAINTAINER Manohar Castelino "manohar.r.castelino@intel.com"

RUN swupd update -s && \
    swupd update && \
    swupd bundle-add containers-basic

RUN mkdir -p /var/run/ && \
    mkdir -p /etc/docker/ && \
    mkdir -p /run/opencontainer/containers/
    
#Run swupd multiple time for now so that we upgrade across format bumps
#This ensures you always have the latest clearlinux image even if the 
#one on dockerhub has not been updated
RUN swupd update		

RUN swupd update		

RUN swupd update		

RUN swupd update

RUN echo -e "#!/bin/bash\ndockerd --add-runtime cor=/usr/bin/cc-oci-runtime --default-runtime=cor --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 --storage-driver=vfs &> /tmp/docker.log &" > /root/run_dockerd.sh && chmod +x /root/run_dockerd.sh

ENV HOME /root
WORKDIR $HOME

CMD bash -C '/root/run_dockerd.sh';'bash'

