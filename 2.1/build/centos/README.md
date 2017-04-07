# Build the CentOS builder Docker container 

```
# docker build -t centos-clear-containers .
```

# Generate the qemu-lite & cc-oci-runtime RPMs:

## Host build directory

The RPMs will be copied into a directory of your choice, e.g. `/tmp/build`.

Make sure you have write access on that directory.

```
# export BUILD_DIR=/tmp/build
# export VERSION=2.1.2
# docker run -ti --rm -v $BUILD_DIR:/home/cc/build -v $PWD/../build-rpms.sh:/usr/bin/build-rpms.sh centos-clear-containers /usr/bin/build-rpms.sh $VERSION
```

The RPMs for cc-oci-runtime & qemu-lite will be at `$BUILD_DIR`
