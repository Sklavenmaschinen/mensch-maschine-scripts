#!/bin/bash

help=$(cat <<EOF
  Build the whole environment for RaspberryPi (ARM) or any other x86_64 OS.

Executed tasks includes:
 - Clean docker
 - Build artifacts
 - Build docker

Available options are:

   -h|--help       Display this help and exit

   --arm           Specify build architecture as ARM
   --x86_64        Specify build architecture as x86_64

   -b|--branch {}  Specify a branch to build (the images will be tagged with the
                   branch name and can not be released), if no branch specified,
                   master will be built as a releasable image
   --dirty         Enable dirty mode, build will not checkout to the specified
                   branch (-b or --branch) nor stash changes before building, it
                   will build the current branch of each app with the current
                   changes on it.

  Usage:
   ./build.sh [ -h|-help ] [ --arm|x86_64 ] [ [-b|--branch master] | [--dirty] ]

EOF
)

printf "%s\n\n" "$help"
