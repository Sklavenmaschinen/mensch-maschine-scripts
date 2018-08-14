#!/bin/bash

BUILD_ARC=${1,,}
BRANCH=$2
ALIAS=${3,,}

printf "\n> Stopping $BUILD_ARC-$ALIAS containers\n"
docker ps | grep $BUILD_ARC-$ALIAS | grep $BRANCH | awk '{print $1}' | xargs -I % docker stop %

printf "\n> Removing $BUILD_ARC-$ALIAS stopped containers\n"
docker ps -a | grep $BUILD_ARC-$ALIAS | grep $BRANCH | awk '{print $1}' | xargs -I % docker rm -f %

printf "\n> Removing $BUILD_ARC-$ALIAS images\n"
docker images | grep $BUILD_ARC-$ALIAS | grep $BRANCH | awk '{print $3}' | xargs -I % docker rmi -f %
