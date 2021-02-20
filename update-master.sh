#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
SCRIPTDIR=$(readlink -f "$SCRIPTDIR")

cd "$SCRIPTDIR/gpg4win"
git fetch --all
git merge upstream/master -m "merge upstream/master"
git push -q origin master
