# docker-nginx-self-signed-ssl


Run nginx with self-signed SSL certificate

```
docker run -d -p 4443:4443 --volume $(pwd):/opt/www --name local.codeclou.io codeclou/docker-nginx-self-signed-ssl:latest
```

Now you can access `https://local.codeclou.io:4443/` which works with a self-signed certificate.

----


Run before each following run to delete existing `local.codeclou.io` named container to avoid errors when starting again:

```
if [ ! -z $(docker ps -a | grep local.codeclou.io | awk '{ print $1 }') ]; then docker rm -f local.codeclou.io; fi
```


----

`local.codeclou.io` always points to `127.0.0.1` but if you use the name to link containers together the DNS gets changed for you. 

Example: Link a selenium Standalone to your named nginx-container

```
docker run -d -p 4444:4444 --link local.codeclou.io selenium/standalone-chrome:3.0.1-aluminum
```

### License

  * Dockerfile and Image is provided under [MIT License](https://github.com/codeclou/docker-nginx-self-signed-ssl/blob/master/LICENSE.md)
