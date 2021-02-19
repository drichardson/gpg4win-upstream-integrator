#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
SCRIPTDIR=$(readlink -f "$SCRIPTDIR")

cd "$SCRIPTDIR/gpg4win"
git fetch --all
git merge --ff-only upstream/master
git push -q origin master
