#!/bin/sh

. ./buildenv.sh

echo "Removing existing container, if exists"
docker rm -f ${DOCKER_IMAGE_NAME}

echo "Launching new container"
sudo docker run \
    -v $(pwd):/app \
    --name=${DOCKER_IMAGE_NAME} \
    -ti ${DOCKER_BUILD_TAG} \
    java -jar blaze.jar
