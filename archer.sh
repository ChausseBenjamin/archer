#!/bin/sh

# Base Settings
user="master"
dir=$(pwd)

echo Remove the dumb beep sound
sudo echo blacklist pcspkr >> /etc/modprobe.d/blacklist

echo Configuring ssh
mkdir -p ~/.ssh
ls ~/.ssh | grep id_rsa.pub || ssh-keygen -t rsa -b 4096 -C "benjamin@chausse.xyz" -q -N "" -f $HOME/.ssh/id_rsa

echo Installing yay
sudo pacman -S --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -sir
cd $dir

echo Adding the candy flair to pacman
sudo sed -i 's/#Color$/Color\nILoveCandy/g' /etc/pacman.conf

echo Installing packages
yay -S --noconfirm $(cat packages.tm | sed 's/#.*//g')

echo Installing R essential packages
for f in xtable ggplot2 plot3D
    do
    sudo R --vanilla -e "install.packages('"$f"', repos='http://cran.us.r-project.org')"
done

echo Installing fiche for terminal pastebins
git clone https://github.com/solusipse/fiche.git /tmp/fiche
cd /tmp/fiche && make && sudo make install

# Pause to add public key to server
puburl="$(cat ~/.ssh/id_rsa.pub | nc termbin.com 9999)"
printf "You may want to give this computer access to your git server...\n
	add the newly created public key to your server.\n
	You can access it here: $puburl\n
	or as a qr code:\n"
qr $puburl
printf "Consider adding this public key to your dropbox account.\n"
read -p "Press enter to continue"


echo Installing my builds of suckless utilities
for i in dmenu dwm st slock sent dwmblocks
do
	cd /tmp
	git clone git://git.chausse.xyz/$i
	cd $i && make && sudo make install
done

echo Setting up vim-Plug - neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall +qall > /dev/null

echo Set dash as the default shell for sh scripts
sudo rm /usr/bin/sh
sudo ln -s $(which dash) /usr/bin/sh

echo Enabling Yubikey support in firefox
sudo cp $dir/70-u2f.rules /etc/udev/rules.d/

echo Setting up time
sudo timedatectl set-ntp true

echo Setting up cronjobs
cd $dir
cat crontab  >> /var/spool/cron/master

echo Installing Goobook
pip install --user goobook

echo Setting up the wallpaper
cp $pwd/wall.jpg ~/.cache/wall.png/

echo setting up dotfiles with yadm
yadm clone git://git.chausse.xyz/dotfiles
