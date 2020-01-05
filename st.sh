#!/bin/sh

cwd=$(pwd)
mkdir -p $HOME/Compilation
git clone https://github.com/ChausseBenjamin/st.git $HOME/Compilation/st
cd $HOME/Compilation/st
make && sudo make install
cd "$cwd"
