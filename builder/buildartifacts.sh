#!/bin/bash

BUILD_ARC=$1
ALIAS=$2


if [ -f "pom.xml" ]; then
  printf "\n> Building $ALIAS as a maven project\n"
  # mvn clean install

elif [ -f "package.json" ]; then
  printf "\n> Building $ALIAS as a npm project\n"
  # npm install
  # npm run build

elif [ -f "custombuild.sh" ]; then
  printf "\n> Building $ALIAS as a custom build project\n"
  # bash custombuild.sh $BUILD_ARC

else
  printf "\n> $ALIAS don't have any mapped build script, skipping\n"
fi
