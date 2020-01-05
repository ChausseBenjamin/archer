#!/bin/sh

ssh-keygen -b 4096 -t rsa -f $HOME/.ssh/id_rsa -q -N ""
cat $HOME/.ssh/id_rsa.pub | xsel -b && notify-send "New ssh key copied to clipboard"
$BROWSER https://github.com/settings/keys


