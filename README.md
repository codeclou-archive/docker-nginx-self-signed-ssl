# docker-nginx-self-signed-ssl


[![](https://codeclou.github.io/doc/badges/generated/docker-image-size-6.svg)](https://hub.docker.com/r/codeclou/docker-nginx-self-signed-ssl/tags/) [![](https://codeclou.github.io/doc/badges/generated/docker-from-alpine-3.5.svg)](https://alpinelinux.org/) [![](https://codeclou.github.io/doc/badges/generated/docker-run-as-non-root.svg)](https://docs.docker.com/engine/reference/builder/#/user)

Docker-Image to run nginx with a self-signed SSL certificate.



-----
&nbsp;

### Prerequisites

 * Runs as non-root with fixed UID 10777 and GID 10777. See [howto prepare volume permissions](https://github.com/codeclou/doc/blob/master/docker/README.md).
 * See [howto use SystemD for named Docker-Containers and system startup](https://github.com/codeclou/doc/blob/master/docker/README.md).



-----
&nbsp;



### Usage

Run demo site.

```
docker run \
    --name local.codeclou.io
    -i -t \
    -p 4443:4443 \
    --volume $(pwd)/demo-site/:/opt/www \
   codeclou/docker-nginx-self-signed-ssl:latest
```

Now you can access from host computer `https://local.codeclou.io:4443/` which works with a self-signed certificate.
`local.codeclou.io` always points to `127.0.0.1` but if you use the name to link containers together the DNS gets changed for you. 


Example: Link a selenium-standalone-instance to your named nginx-container like so.

```
docker run \
    -d \
    -p 4444:4444 \
    --link local.codeclou.io \
    selenium/standalone-chrome:3.0.1-aluminum
```

-----
&nbsp;

### License, Liability & Support

 * [![](https://codeclou.github.io/doc/docker-warranty-notice.svg?v1)](https://github.com/codeclou/docker-nginx-self-signed-ssl/blob/master/LICENSE.md)
 * Dockerfile and Image is provided under [MIT License](https://github.com/codeclou/docker-nginx-self-signed-ssl/blob/master/LICENSE.md)
