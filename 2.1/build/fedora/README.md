# To build
`$ sudo docker build -t fedora-clear-containers .`

# To generate the qemu-lite & cc-oci-runtime rpms just run this:
`$ sudo docker run -ti --rm -v $PWD/../rpmbuild:/root/rpmbuild -v $PWD/../build-rpms.sh:/usr/bin/build-rpms.sh fedora-clear-containers /usr/bin/build-rpms.sh VERSION`

Currently this is working with version cc-oci-runtime 2.1.1, change `VERSION` to 2.1.1

The rpms for cc-oci-runtime & qemu-lite will be at `$PWD/../rpmbuild/RPMS/x86_64`
