# Errbit Docker image

Dockerfile and repository for running [errbit] in a docker container.

It is automatically built as [griff/errbit].

The short version of how to get it running:
```
docker run -d --name mongodb mongo
docker run --rm --link mongodb:mongodb griff/errbit seed
docker run -d --name errbit --link mongodb:mongodb -p 3000:3000 griff/errbit
```

And then point your browser at ```http://localhost:3000```


## Configuration

The image supports configuration using environment variables.
See the errbit documentation for list of [available variables].

### Changing the port

Normally you don't need to change the port inside the container because you
can just change what the port is published as while still keeping the same
port inside the container.

In short you can do this to have errbit be on port 5000:

```
docker run -d --name errbit --link mongodb:mongodb -p 5000:3000 griff/errbit
```

But should you need to change the port inside the container you can do so by
setting the ```PORT``` environment variable like this:

```
docker run -d --name errbit --link mongodb:mongodb -e PORT=5000 -p 5000:5000 griff/errbit
```

## Upgrade

To upgrade you need to replace the errbit container and upgrade the database.
```
docker stop errbit
docker rm errbit
docker pull griff/errbit
docker run --rm --link mongodb:mongodb griff/errbit upgrade
docker run -d --name errbit --link mongodb:mongodb -p 3000:3000 griff/errbit
```

[errbit]: https://github.com/errbit/errbit
[griff/errbit]: https://hub.docker.com/r/griff/errbit/
[available variables]: https://github.com/errbit/errbit/blob/master/docs/configuration.md
