FROM java:8

RUN apt-get update && apt-get install -y apt-transport-https
RUN echo deb http://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list && \
  apt-key adv --keyserver pgp.mit.edu --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 && \
  apt-get update && \
  apt-get install -y sudo wget ca-certificates lxc-docker-1.6.0

# copied from https://bitbucket.org/ariya/docker-centos/src/a4348d8b6aeca6ea2e93d370ab9d80cb2b19f4ca/centos7-teamcity-agent/Dockerfile?at=master

COPY setup-agent.sh /setup-agent.sh

EXPOSE 9090
CMD sudo -s -- sh -c "TEAMCITY_SERVER=$TEAMCITY_SERVER bash /setup-agent.sh run"
