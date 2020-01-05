#!/bin/bash

sudo sed -i "s/^#Color/Color/;
          s/^#TotalDownload/TotalDownload\nILoveCandy/" /etc/pacman.conf
