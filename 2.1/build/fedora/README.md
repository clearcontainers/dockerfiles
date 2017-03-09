# Build the Fedora builder Docker container 

```
# docker build -t fedora-clear-containers .
```

# Generate the qemu-lite and cc-oci-runtime RPMs

## Host build directory

The RPMs will be copied into a directory of your choice, e.g. `/tmp/build`
Make sure you have write access on that directory.

```
# export BUILD_DIR=/tmp/build
# export VERSION=2.1.1
# docker run -ti --rm -v $BUILD_DIR:/home/cc/build -v $PWD/../build-rpms.sh:/usr/bin/build-rpms.sh fedora-clear-containers /usr/bin/build-rpms.sh $VERSION
```

The RPMs for cc-oci-runtime and qemu-lite will be at `$BUILD_DIR`
