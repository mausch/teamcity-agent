# Dockerfile for a TeamCity agent

Dockerhub image: https://registry.hub.docker.com/u/mausch/teamcity-agent/

Based on https://bitbucket.org/ariya/docker-centos/src/a4348d8b6aeca6ea2e93d370ab9d80cb2b19f4ca/centos7-teamcity-agent/?at=master .

## Usage:

```
docker run -d -p 9090:9090 --name teamcity-agent --privileged=true \
  -e TEAMCITY_SERVER=http://10.0.0.10:8000 \
  -e DOCKER_OPTS="--insecure-registry 10.0.0.10:6000 --insecure-registry http://10.0.0.10:6000" \
  -e DOCKER_HOST="tcp://10.0.0.22:2375" \
  mausch/teamcity-agent
```

`DOCKER_OPTS` and `DOCKER_HOST` are optional.<br/>
`DOCKER_HOST` is needed if the host's docker daemon is not listening on the default socket.

After the container starts, you need to authorise the agent in the server.

This image includes docker so you can:

1. create an image of your app, then 
1. test your app inside a container of this image, then 
1. push the tested image to a registry.

Or simply run the build environment in a docker container, then push the artifacts to some package repository.
