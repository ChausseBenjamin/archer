#!/bin/sh

packages="xtable blogdown ggplot2 plot3D"

for f in $packages
    do
    sudo R --vanilla -e "install.packages('"$f"', repos='http://cran.us.r-project.org')"
done
