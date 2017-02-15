# cc-sandbox

A containerized environment for Clear Containers 2.0 cc-oci-runtime.  This allows you to try docker with the [cc-oci-runtime] (https://github.com/01org/cc-oci-runtime) within a privileged docker container 

## Running this container
```
sudo docker run -it -e HTTP_PROXY=$http_proxy -e HTTPS_PROXY=$https_proxy --privileged clearcontainers/clearlinux
```

The container needs to run as privileged in order to launch docker clear containers. Also the proxy settings, if any; need to be propagated into the container as the docker daemon which runs within the container will need to reach out to the image repositories.

## To launch containers within this container

```
 docker run -it debian
```

# Building this container from its Dockerfile

```
git clone https://github.com/clearcontainers/dockerfiles
cd dockerfiles/clearlinux
sudo docker build --build-arg HTTP_PROXY=$http_proxy --build-arg HTTPS_PROXY=$https_proxy -t clearcontainers/clearlinux .
```
