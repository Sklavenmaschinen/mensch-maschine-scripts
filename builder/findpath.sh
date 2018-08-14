#!/bin/bash

ROOT=$1
ALIAS=$2

while [ -z "$MATCHING_PATH" ]; do
  LASTPATH=${LASTPATH:-$ROOT}
  cd $LASTPATH

  ls -ld */ >/dev/null 2>&1
  if [ $? = 0 ]; then
    CURRENT_FOLDERS=$(ls -d */ | grep $ALIAS)
    for DIR in ${CURRENT_FOLDERS[@]//\// }; do
      MATCHING_PATH="$LASTPATH/$DIR"
      break
    done
  fi
  cd ..
  LASTPATH=$(pwd)
  if [ $LASTPATH = "/" ]; then
    break
  fi
done

printf "$MATCHING_PATH"
