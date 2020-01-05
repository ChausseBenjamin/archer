#!/bin/bash

cwd=$(pwd)
git clone https://aur.archlinux.org/spotify.git /tmp/spotify
cd /tmp/spotify
sed -i "s/https:\/\/repository-origin/http:\/\/repository/" PKGBUILD
makepkg -sir --noconfirm --skipinteg
cd "$cwd"

