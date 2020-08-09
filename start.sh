#!/usr/bin/env bash

# vars
DOCKER_FLAGS="--rm -p 9901:9901 --name velocity"
# prepare
CURREND_DIR="$(pwd)"
BUILD_DIR="$CURREND_DIR/build"
mkdir $BUILD_DIR
# copy files
cp $CURREND_DIR/configs/* $BUILD_DIR
# get latest velocity version
VELOCITY_RAW="$(curl -s https://ci.velocitypowered.com/job/velocity-1.1.0/lastBuild/api/python?pretty=true | grep relativePath)"
VELOCITY_FILE="${VELOCITY_RAW:41:-1}"
VELOCITY_URL="https://ci.velocitypowered.com/job/velocity-1.1.0/lastBuild/artifact/proxy/build/libs/$VELOCITY_FILE"
wget $VELOCITY_URL -O $BUILD_DIR/velocity.jar
# download plugins
LUCKYP_RAW="$(curl -s https://ci.lucko.me/job/LuckPerms/lastSuccessfulBuild//api/python?pretty=true | grep velocity)"
LUCKYP_FILE="${LUCKYP_RAW:44:-1}"
LUCKYP_URL="https://ci.lucko.me/job/LuckPerms/1145/artifact/velocity/build/libs/$LUCKYP_FILE"
wget $LUCKYP_URL -O $BUILD_DIR/plugins/


# build & start container
podman build -t velocity .
podman run $DOCKER_FLAGS velocity
# cleanup
rm -r $BUILD_DIR
