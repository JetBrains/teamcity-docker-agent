#!/bin/bash

if [ "$DOCKER_IN_DOCKER" = "start" ] ; then
 service docker start
 echo "Docker daemon started"
fi