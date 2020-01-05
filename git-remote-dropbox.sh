#!/bin/sh

# This script supposes you have a usb key mounted in /mnt
# This drive must contain your git-remote-dropbox.json finle in it's root...

mkdir -p $HOME/.config/git
cp /mnt/git-remote-dropbox.json $HOME/.config/git/git-remote-dropbox.json
pip install --user git-remote-dropbox
