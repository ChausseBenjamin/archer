#!/bin/sh
cwd=$(pwd)
sudo pacman -S --noconfirm git
git clone https://aur.archlinux.org/yay.git /tmp/yay
git config --global user.email "benjamin@chausse.xyz"
git config --global user.name "Benjamin Chausse"
cd /tmp/yay
makepkg -si --noconfirm
cd "$cwd"


