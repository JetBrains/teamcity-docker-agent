#!/bin/bash

if [ "$DOCKER_IN_DOCKER" = "start" ] ; then
  rm /var/run/docker.pid 2>/dev/null
  if [ -x "$(command -v service)" ]; then
    service docker start
  else
    dockerd >/tmp/docker.stdout 2>/tmp/docker.stderr &
  fi
    echo "Docker daemon started"
fi
