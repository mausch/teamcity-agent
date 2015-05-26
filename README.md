# Dockerfile for a TeamCity agent

Dockerhub image: https://registry.hub.docker.com/u/mausch/teamcity-agent/

Based on https://bitbucket.org/ariya/docker-centos/src/a4348d8b6aeca6ea2e93d370ab9d80cb2b19f4ca/centos7-teamcity-agent/?at=master .

## Usage:

```
docker run -d -p 9090:9090 --name teamcity-agent --privileged=true \
  -e TEAMCITY_SERVER=http://10.0.0.10:8000 \
  -e DOCKER_OPTS="--insecure-registry 10.0.0.10:6000"
  mausch/teamcity-agent
```

`DOCKER_OPTS` is optional.

After the container starts, you need to authorise the agent in the server.

This image includes docker so you can:

* create an image of your app, then 
* test your app inside a container of this image, then 
* push the tested image to a registry.

