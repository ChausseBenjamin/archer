#!/bin/sh

# Base Settings
user="master"
dir=$(pwd)

echo Remove the dumb beep sound
echo blacklist pcspkr >> /etc/modprobe.d/blacklist

echo Configuring ssh
mkdir -p ~/.ssh
ls ~/.ssh | grep id_rsa.pub || ssh-keygen -t rsa -b 4096 -C "benjamin@chausse.xyz" -q -N ""

echo Installing yay
sudo pacman -S --noconfirm git base-devel
cd /tmp
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -sir 

echo Adding the candy flair to pacman
sudo echo ILoveCandy >> /etc/pacman.conf
sudo sed -i 's/#Color$/Color/g' /etc/pacman.conf

echo Installing packages
packages=$(sed "s/#.*$//; /^$/d" packages.tm)
yay -S --noconfirm $packages

echo Installing R essential packages
for f in xtable ggplot2 plot3D
    do
    sudo R --vanilla -e "install.packages('"$f"', repos='http://cran.us.r-project.org')"
done

echo Installing fiche for terminal pastebins
cd /tmp
git clone https://github.com/solusipse/fiche.git
cd fiche && make && sudo make install

# Pause to add public key to server
puburl="$(cat ~/id_rsa.pub | nc termbin.com 9999)"
printf "You may want to give this computer access to your git server...\n
	add the newly created public key to your server.\n
	You can access it here: $puburl"
read -p "Press enter to continue"


echo Installing my builds of suckless utilities
for i in dmenu dwm st slock sent
do
	cd /tmp
	git clone https://git.chausse.xyz/$i
	cd $i && make && sudo make install
done

echo Set dash as the default shell for sh scripts
sudo rm /usr/bin/sh
ln -s $(which dash) /usr/bin/sh

echo Setting up the wallpaper
cp $pwd && cp wall.jpg ~/.config/
