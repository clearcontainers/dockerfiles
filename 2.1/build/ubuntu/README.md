# Build cc-oci-runtime on Ubuntu

This Dockerfile will install all dependencies required and
build cc-oci-runtime inside a container.

```
$ docker build -t ubuntu-clear-containers .
$ docker run -ti --privileged ubuntu-clear-containers
```

