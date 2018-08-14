#!/bin/bash

ROOT="$(pwd)"

CONTAINERS=(
  mensch-maschine-db
  mensch-maschine-worker
  mensch-maschine-api
  mensch-maschine-webapp
)

POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
      --help) ./help.sh; exit 0 ;;

      --patch) ARG_BUMPV=PATCH; shift ;;
      --minor) ARG_BUMPV=MINOR; shift ;;
      --major) ARG_BUMPV=MAJOR; shift ;;

      --arm) ARC_DEFINED=1; RELEASE_ARC="ARM"; shift ;;
      --x86_64) ARC_DEFINED=1; RELEASE_ARC="X86_64"; shift ;;

      *) POSITIONAL+=("$1"); shift ;;
  esac
done
set -- "${POSITIONAL[@]}"

# Defaults
ARG_BUMPV=${ARG_BUMPV:-PATCH}
