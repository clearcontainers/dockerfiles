# To build
`$ sudo docker build -t centos-clear-containers .`

# To generate the qemu-lite & cc-oci-runtime rpms just run this:
`$ sudo docker run -ti --rm -v $PWD/../rpmbuild:/root/rpmbuild -v $PWD/../build-rpms.sh:/usr/bin/build-rpms.sh centos-clear-containers /usr/bin/build-rpms.sh`

The rpms for cc-oci-runtime & qemu-lite will be at `$PWD/../rpmbuild/RPMS/x86_64`
