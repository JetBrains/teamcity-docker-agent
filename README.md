[![official JetBrains project](http://jb.gg/badges/official-plastic.svg)](https://confluence.jetbrains.com/display/ALL/JetBrains+on+GitHub)

## TeamCity Agent Image Dockerfile

This project contains the Dockerfiles and all necessary scripts to build the Linux and Windows Docker images and run a TeamCity Build Agent inside the container.

You can pull the ready-to-use image from the Docker Hub repository
                                     
`docker pull jetbrains/teamcity-agent`

If you need to build your own image, you need to perform the following:

1) Pull our minimal agent image and re-tag it 
```
docker pull jetbrains/teamcity-minimal-agent
docker tag jetbrains/teamcity-minimal-agent teamcity-minimal-agent
```

If you want to start with your own base agent image, see our [instructions](https://github.com/JetBrains/teamcity-docker-minimal-agent) on how to build it.
If you change the operation system, update the following line in the in Dockerfile appropriately:  
```
apt-get install -y docker-engine=1.13.0-0~ubuntu-xenial
```

3) Run the `docker build` command:
```
docker build -t teamcity-agent
```

See our [detailed instructions](https://hub.docker.com/r/jetbrains/teamcity-agent/) on how to use the image in the Docker Hub repository.
