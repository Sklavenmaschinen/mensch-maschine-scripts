#!/bin/bash

# Defaults
BRANCH=master
DIRTY_BUILD=0
ROOT="$(pwd)"
CONTAINERS=(
  mensch-maschine-db
  mensch-maschine-worker
  mensch-maschine-api
  mensch-maschine-webapp
)

# Extract args
POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
      -h|--help) ./help.sh; exit 0 ;;
      -b|--branch) BRANCH="$2"; shift; shift ;;
      --dirty) DIRTY_BUILD=1; shift ;;

      --arm) ARC_DEFINED=1; BUILD_ARC="ARM"; shift ;;
      --x86_64) ARC_DEFINED=1; BUILD_ARC="X86_64"; shift ;;

      *) POSITIONAL+=("$1"); shift ;;
  esac
done
set -- "${POSITIONAL[@]}"

# Print warnings
if [ "$DIRTY_BUILD" = "1" ]; then
  printf "> Attention, any changes in your repositories will not be stashed before building.\n"

  if [ "$BRANCH" != "master" ]; then
    printf "> Attention, your specified branch '$BRANCH' will not be used because dirty mode is on, the current branch of each project will be used instead.\n"
  fi

elif [ "$BRANCH" != "master" ]; then
  printf "> Attention, you are building a non-releaseable image for branch '$BRANCH'.\n"
fi
