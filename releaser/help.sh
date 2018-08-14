#!/bin/bash

help=$(cat <<EOF
  Create and tag a version for the previously built environment for RaspberryPi (ARM) or any other x86_64 OS.

Executed tasks includes:
 - Tag docker images
 - Publish docker images
 - Bump version
 - Create git tag

Available options are:

   -h|--help       Display this help and exit

   --arm           Specify build architecture as ARM
   --x86_64        Specify build architecture as x86_64

   --patch         Bump Patch version from all apps    (default)
   --minor         Bump Minor version from all apps
   --major         Bump Major version from all apps

  Usage:
   ./release.sh [ -h|-help ] [ --patch|minor|major ] [ --arm|x86_64 ]

EOF
)

printf "%s\n\n" "$help"
