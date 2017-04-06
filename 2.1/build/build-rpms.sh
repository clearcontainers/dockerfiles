#!/bin/bash
# $1 Release version
qemu_lite_version=da5004e3ffc6a79df82d1b9d8f8533c4045f193c

if [ -z "$1" ]; then
    echo "No cc-oci-runtime version specified"
    echo "Usage:"
    echo "$0 <version>   # version can be a tag or a commit id"
    echo
    exit 1
fi

# version can't have '-' character
version=$(echo $1 | tr '-' '.')

# Setup cc-oci-runtime
rpmdev-setuptree
cd ~/rpmbuild/SOURCES

# Download cc-oci-runtime.tar.gz
curl -kL https://github.com/01org/cc-oci-runtime/archive/$1.tar.gz -o cc-oci-runtime-$version.tar.gz

# Download qemu-lite.tar.gz
curl -OkL https://github.com/01org/qemu-lite/archive/$qemu_lite_version.tar.gz

# Update cc-oci-runtime.spec template
sed "s/VERSION/$version/g; s/PACKAGE/$1/g" ~/rpmbuild/SOURCES/cc-oci-runtime.spec-template > ~/rpmbuild/SOURCES/cc-oci-runtime.spec

# Update qemu-lite.spec template
sed "s/QEMU_LITE_VERSION/$qemu_lite_version/g" ~/rpmbuild/SOURCES/qemu-lite.spec-template > ~/rpmbuild/SOURCES/qemu-lite.spec

# Build qemu-lite
rpmbuild -ba qemu-lite.spec

# Build cc-oci-runtime
rpmbuild -ba cc-oci-runtime.spec

# Copy RPMs
cp ~/rpmbuild/RPMS/x86_64/* ~/build/
