#!/bin/sh

. ./buildenv.sh

sudo docker exec \
    -ti ${DOCKER_IMAGE_NAME} \
    bash
