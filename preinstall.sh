#!/bin/bash
# install prerequirements

# install jdownloader desktop file
sudo cp ~/bin/jdownloader.desktop /usr/share/applications/

if [[  ]] ; then
    sudo update-menus
    sudo apt-get update
    sudo apt-get upgrade
    #sudo apt-get install ...
elif [[  ]] ; then
    sudo pacman -Syu
    sudo pacman -S colordiff
    if [[-z "`which yaourt`" ]] ; then
        # install yaourt
    fi
    yaourt -S archey2
else
    echo "Unknown linux distribution. Supported dists are Debian and Archlinux."
fi


