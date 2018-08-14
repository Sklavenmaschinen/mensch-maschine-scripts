#!/bin/bash

printf " --- Mensch Maschine builder --- \n"

source env.sh

while [ -z "$ARC_DEFINED" ]; do
  printf "\nBuild for what architecture?\n\n"
  printf "1. ARM\n"
  printf "2. x86_64\n\n"
  read -p "Enter value: " BUILD_ARC

  case $BUILD_ARC in
    1) BUILD_ARC="ARM"; ARC_DEFINED=1 ;;
    2) BUILD_ARC="X86_64"; ARC_DEFINED=1 ;;
    *) printf "Invalid option, you must choose the number related to the build architecture\n\n" ;;
  esac
done

printf "\n"
read -p "Architecture type $BUILD_ARC selected, proceed? [y/N]: " BUILD_PROCEED

if [ "${BUILD_PROCEED^^}" = "Y" ]; then
  BUILD_START=`date +%s`
  printf "\n> Build started at %s\n" "$(date +"%m/%d/%y %r")"

  printf "\n\n --- Cleaning up docker ---\n"
  printf "%s\n" "${CONTAINERS[@]}" | xargs -I % bash cleardocker.sh $BUILD_ARC $BRANCH %

  printf "\n\n --- Building apps ---\n"
  printf "%s\n" "${CONTAINERS[@]}" | xargs -I % bash buildapp.sh $ROOT $BUILD_ARC $BRANCH $DIRTY_BUILD %

  BUILD_END=`date +%s`
  printf "\n> Build completed at %s\n" "$(date +"%m/%d/%y %r")"
  printf "It took %s seconds to complete the build.\n\n" "$((BUILD_END-BUILD_START))"
else
  printf "Goodbye, then.\n"
fi
