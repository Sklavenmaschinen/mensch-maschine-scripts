#!/bin/bash

ROOT=$1
BUILD_ARC=${2,,}
BRANCH=$3
DIRTY_BUILD=$4
ALIAS=${5,,}

cd $(bash findpath.sh $ROOT $ALIAS)

# Get curent branch
INITIAL_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')


# Check dirty build option
if [ "$DIRTY_BUILD" = "0" ]; then

  # Stash local changes if any changes found
  if [ ! -z "$(git status --porcelain | grep -v ??)" ]; then
    git stash
    STASHED=1
  fi

  # if curent branch is different, checkout to the desired branch
  if [ "$INITIAL_BRANCH" != "$BRANCH" ]; then
    git checkout $BRANCH
  fi
fi


# Build artifacts
bash $ROOT/buildartifacts.sh $BUILD_ARC $ALIAS

# Build docker
BUILIND_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
bash $ROOT/builddocker.sh $BUILD_ARC $ALIAS $BUILIND_BRANCH


# Check dirty build option
if [ "$DIRTY_BUILD" = "0" ]; then

  # Return to the previous branch
  if [ "$INITIAL_BRANCH" != "$BRANCH" ]; then
    git checkout $INITIAL_BRANCH
  fi

  # Apply and drop stash if stashed before
  if [ "$STASHED" = "1" ]; then
    git stash pop
  fi
fi
