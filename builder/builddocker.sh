#!/bin/bash

BUILD_ARC=$1
ALIAS=$2
BRANCH=$3

if [ -d "docker" ] && [ -f "docker/Dockerfile.$BUILD_ARC" ]; then
  printf "\n> Building $ALIAS Dockerfile.$BUILD_ARC $BRANCH\n"

fi
