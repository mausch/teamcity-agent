#!/usr/bin/env bash
# copied from https://bitbucket.org/ariya/docker-centos/raw/a4348d8b6aeca6ea2e93d370ab9d80cb2b19f4ca/centos7-teamcity-agent/setup-agent.sh

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
AGENT_DIR="${HOME}/agent"

if [ -z "$TEAMCITY_SERVER" ]; then
    echo "Fatal error: TEAMCITY_SERVER is not set."
    echo "Launch this container with -e TEAMCITY_SERVER=http://servername:port."
    echo
    exit
fi

if [ ! -z "$DOCKER_OPTS" ]; then
    echo "DOCKER_OPTS=$DOCKER_OPTS" >> /etc/default/docker
    service docker stop
    service docker start 
fi

if [ ! -z "$DOCKER_HOST" ]; then
    echo "DOCKER_HOST=$DOCKER_HOST" >> /etc/default/docker
    service docker stop
    service docker start 
fi

service docker start

if [ ! -d "$AGENT_DIR" ]; then
    cd ${HOME}
    echo "Setting up TeamCity agent for the first time..."
    echo "Agent will be installed to ${AGENT_DIR}."
    mkdir -p $AGENT_DIR
    wget $TEAMCITY_SERVER/update/buildAgent.zip
    unzip -q -d $AGENT_DIR buildAgent.zip
    rm buildAgent.zip
    chmod +x $AGENT_DIR/bin/agent.sh
    echo "serverUrl=${TEAMCITY_SERVER}" > $AGENT_DIR/conf/buildAgent.properties
    echo "name=" >> $AGENT_DIR/conf/buildAgent.properties
    echo "workDir=../work" >> $AGENT_DIR/conf/buildAgent.properties
    echo "tempDir=../temp" >> $AGENT_DIR/conf/buildAgent.properties
    echo "systemDir=../system" >> $AGENT_DIR/conf/buildAgent.properties
else
    echo "Using agent at ${AGENT_DIR}."
fi
$AGENT_DIR/bin/agent.sh run
