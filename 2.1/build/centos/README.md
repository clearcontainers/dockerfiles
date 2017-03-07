# Build the CentOS builder Docker container 
`$ sudo docker build -t centos-clear-containers .`

# Generate the qemu-lite & cc-oci-runtime rpms just run this:
As root, run:

```
# export VERSION=2.1.1
# docker run -ti --rm -v $PWD/../rpmbuild:/root/rpmbuild -v $PWD/../build-rpms.sh:/usr/bin/build-rpms.sh centos-clear-containers /usr/bin/build-rpms.sh $VERSION
```
The rpms for cc-oci-runtime & qemu-lite will be at `$PWD/../rpmbuild/RPMS/x86_64`
