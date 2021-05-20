#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
SCRIPTDIR=$(readlink -f "$SCRIPTDIR")

cd "$SCRIPTDIR/gpg4win"
git fetch --all -p
git reset --hard origin/master
git merge upstream/master
git push -qf origin master
