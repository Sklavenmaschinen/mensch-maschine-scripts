#!/bin/bash

printf " --- Mensch Maschine releaser --- \n"

source env.sh

while [ -z "$ARC_DEFINED" ]; do
  printf "\nRelease for what architecture?\n\n"
  printf "1. ARM\n"
  printf "2. x86_64\n\n"
  read -p "Enter value: " RELEASE_ARC

  case $RELEASE_ARC in
    1) RELEASE_ARC="ARM"; ARC_DEFINED=1 ;;
    2) RELEASE_ARC="X86_64"; ARC_DEFINED=1 ;;
    *) printf "Invalid option, you must choose the number related to the release architecture\n\n" ;;
  esac
done

printf "\n"
read -p "Architecture type $RELEASE_ARC selected, proceed? [y/N]: " RELEASE_PROCEED

if [ "${RELEASE_PROCEED^^}" = "Y" ]; then
  RELEASE_START=`date +%s`
  printf "\n> Release started at %s\n" "$(date +"%m/%d/%y %r")"

  # printf "\n\n --- Cleaning up docker ---\n"
  # printf "%s\n" "${CONTAINERS[@]}" | xargs -I % bash cleardocker.sh $RELEASE_ARC $BRANCH %

  # printf "\n\n --- Building apps ---\n"
  # printf "%s\n" "${CONTAINERS[@]}" | xargs -I % bash buildapp.sh $ROOT $RELEASE_ARC $BRANCH $DIRTY_BUILD %

  RELEASE_END=`date +%s`
  printf "\n> Release completed at %s\n" "$(date +"%m/%d/%y %r")"
  printf "It took %s seconds to complete the release.\n\n" "$((RELEASE_END-RELEASE_START))"
else
  printf "Goodbye, then.\n"
fi
