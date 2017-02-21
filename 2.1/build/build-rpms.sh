#!/bin/bash

# Download cc-oci-runtime.tar.gz
curl -OkL https://github.com/01org/cc-oci-runtime/archive/2.1.0-rc.6.tar.gz

# Download qemu-lite.tar.gz
curl -OkL https://github.com/01org/qemu-lite/archive/da5004e3ffc6a79df82d1b9d8f8533c4045f193c.tar.gz

# Setup cc-oci-runtime
rpmdev-setuptree
cd ~/rpmbuild/SOURCES
mv ~/2.1.0-rc.6.tar.gz ~/rpmbuild/SOURCES

# Move qemu-lite tar
mv ~/da5004e3ffc6a79df82d1b9d8f8533c4045f193c.tar.gz ~/rpmbuild/SOURCES

# Update cc-oci-runtime tar name
mv ~/rpmbuild/SOURCES/2.1.0-rc.6.tar.gz  ~/rpmbuild/SOURCES/cc-oci-runtime-2.1.0.rc.6.tar.gz

# Check os-distribution for build requirements for cc-oci-runtime
if [ `cat /etc/os-release | grep id | cut -d '=' -f2 | head -1` == "centos" ]; then
    mv 0001-Define-GOPATH-if-there-is-none_centos.patch 0001-Define-GOPATH-if-there-is-none.patch
else
    mv 0001-Define-GOPATH-if-there-is-none_other.patch 0001-Define-GOPATH-if-there-is-none.patch 
fi

# Build cc-oci-runtime
cd ~/rpmbuild/SOURCES && \
    rpmbuild -ba cc-oci-runtime.spec

# Build qemu-lite
cd ~/rpmbuild/SOURCES && \
    rpmbuild -ba qemu-lite.spec
