#!/bin/bash

if [ "$DOCKER_IN_DOCKER" = "start" ] ; then
 service docker start
 echo "Docker daemon started"
 if [ ! -z "$DOCKER_USERNAME" ] && [ ! -z "$DOCKER_PASSWORD" ]; then
  docker login --username=$DOCKER_USERNAME --password=$DOCKER_PASSWORD
 fi
fi
