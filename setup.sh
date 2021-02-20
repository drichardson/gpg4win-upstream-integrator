#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
SCRIPTDIR=$(readlink -f "$SCRIPTDIR")

DEPLOY_KEY="$HOME/.ssh/gpg4win-deploy-key"

cat <<EOF
Add this to $HOME/.ssh/config:

Host github-gpg4win-deploy
        Hostname github.com
	IdentityFile /home/doug/.ssh/gpg4win-deploy-key
EOF

read -p 'Press Enter when you have done this' CONFIRM

echo Setting up deploy keys

if [[ -f "$DEPLOY_KEY" ]]; then
	echo "$DEPLOY_KEY already exists. Remove it if you want to re-run setup."
	exit 1
fi

ssh-keygen -t ed25519 -f "$DEPLOY_KEY" -N ''

cat <<EOF
Copy this public deploy key to:
  https://github.com/drichardson/gpg4win/settings/keys/new
Grant the key write access.
==== COPY BETWEEN THIS ====
EOF
cat $DEPLOY_KEY.pub
cat <<EOF
==== COPY BETWEEN THIS ====
EOF

echo Copy the key above to https://github.com/drichardson/gpg4win/settings/keys/new
read -p 'Press Enter when you have done this.' CONFIRM

echo Configure Repository
cd "$SCRIPTDIR"
git clone git@github-gpg4win-deploy:drichardson/gpg4win.git
cd gpg4win
git remote add upstream git://git.gnupg.org/gpg4win.git

cat <<EOF
Setup complete. You can now run update-master.sh.

If you want to run this every five minutes, install something like the following entry in crontab:

*/5 * * * * /PATH/TO/GPG4WINUPSTREAMINTEGRATOR/cronic /PATH/TO/GPG4WINUPSTREAMINTEGRATOR/update-master.sh
EOF
