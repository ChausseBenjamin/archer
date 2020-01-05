#!/bin/sh

packages=$(sed "s/#.*$//; /^$/d" packages.tm)
yay -S --noconfirm $packages
