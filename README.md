# docker-nginx-self-signed-ssl


Docker image to run nginx with self-signed SSL certificate.

![](https://codeclou.github.io/doc/docker-warranty.svg?v5)

-----

### Usage

Run daemonized as named container.

```
docker run \
    -d 
    --name local.codeclou.io
    -p 4443:4443 
    --volume $(pwd):/opt/www 
   codeclou/docker-nginx-self-signed-ssl:latest
```

Now you can access from host computer `https://local.codeclou.io:4443/` which works with a self-signed certificate.
`local.codeclou.io` always points to `127.0.0.1` but if you use the name to link containers together the DNS gets changed for you. 

Example: Link a selenium Standalone to your named nginx-container

```
docker run  \
    -d \
    -p 4444:4444 \
    --link local.codeclou.io \
    selenium/standalone-chrome:3.0.1-aluminum
```

-----

### License

  * Dockerfile and Image is provided under [MIT License](https://github.com/codeclou/docker-nginx-self-signed-ssl/blob/master/LICENSE.md)
