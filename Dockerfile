FROM java:8

RUN apt-get update && apt-get install -y apt-transport-https


# copied from https://github.com/docker-library/docker/blob/bb15fc25bbd4f51a880cf02f91eab447b1083b75/1.8/Dockerfile

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.8.2
ENV DOCKER_SHA256 97a3f5924b0b831a310efa8bf0a4c91956cd6387c4a8667d27e2b2dd3da67e4d

RUN curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION" -o /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker

# copied from https://bitbucket.org/ariya/docker-centos/src/a4348d8b6aeca6ea2e93d370ab9d80cb2b19f4ca/centos7-teamcity-agent/Dockerfile?at=master

COPY setup-agent.sh /setup-agent.sh

EXPOSE 9090
CMD sudo -s -- sh -c "TEAMCITY_SERVER=$TEAMCITY_SERVER bash /setup-agent.sh run"
