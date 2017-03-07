#!/bin/bash
# $1 Release version

if [ -z "$1" ]; then
    echo "No cc-oci-runtime version specified"
    echo "Usage:"
    echo "$0 <version>   # version can be a tag or a commit id"
    echo
    exit 1
fi

# Download cc-oci-runtime.tar.gz
curl -OkL https://github.com/01org/cc-oci-runtime/archive/$1.tar.gz

# Download qemu-lite.tar.gz
curl -OkL https://github.com/01org/qemu-lite/archive/da5004e3ffc6a79df82d1b9d8f8533c4045f193c.tar.gz

# Setup cc-oci-runtime
rpmdev-setuptree
cd ~/rpmbuild/SOURCES

version=$(echo $1)
mv ~/$1.tar.gz ~/rpmbuild/SOURCES/cc-oci-runtime-$version.tar.gz

# Move qemu-lite tar
mv ~/da5004e3ffc6a79df82d1b9d8f8533c4045f193c.tar.gz ~/rpmbuild/SOURCES

# Update cc-oci-runtime.spec template
sed "s/VERSION/$version/g; s/PACKAGE/$1/g" ~/rpmbuild/SOURCES/cc-oci-runtime.spec-template > ~/rpmbuild/SOURCES/cc-oci-runtime.spec

# Build qemu-lite
cd ~/rpmbuild/SOURCES && \
    rpmbuild -ba qemu-lite.spec

# Build cc-oci-runtime
cd ~/rpmbuild/SOURCES && \
    rpmbuild -ba cc-oci-runtime.spec

