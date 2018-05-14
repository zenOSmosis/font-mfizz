#!/bin/sh

. ./buildenv.sh

sudo docker build -t ${DOCKER_BUILD_TAG} .
