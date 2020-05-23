#!/usr/bin/env bash

# vars
DOCKER_FLAGS="--rm -d -p 9901:9901"
# prepare
CURREND_DIR="$(pwd)"
BUILD_DIR="$CURREND_DIR/build"
mkdir $BUILD_DIR
# copy files
cp $CURREND_DIR/configs/* $BUILD_DIR
# get latest velocity version
VELOCITY_RAW="$(curl -s https://ci.velocitypowered.com/job/velocity/lastStableBuild/api/python?pretty=true | grep relativePath)"
VELOCITY_FILE="${VELOCITY_RAW:41:-1}"
VELOCITY_URL="https://ci.velocitypowered.com/job/velocity/lastStableBuild/artifact/proxy/build/libs/$VELOCITY_FILE"
wget $VELOCITY_URL -O $BUILD_DIR/velocity.jar
# build & start container
docker build -t velocity .
docker run $DOCKER_FLAGS velocity