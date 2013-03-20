#!/bin/bash
# install prerequirements

# install jdownloader desktop file
sudo cp ~/bin/jdownloader.desktop /usr/share/applications/

if [[ -f '/etc/debian_version' ]] ; then
    sudo update-menus
    sudo apt-get update
    sudo apt-get upgrade
    #TODO: check for correct conky package names
    sudo apt-get install dd pv less tree htop powertop conky conky-colors
elif [[ -f '/etc/arch-release' ]] ; then
    sudo pacman -Syu
    sudo pacman -S colordiff dd pv less tree htop powertop conky
    if [[ -z "`which yaourt`" ]] ; then
        sudo pacman -S base-devel

        # install package-query
        wget -O /tmp/package-query.tar.gz https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
        tar -xvzf /tmp/package-query.tar.gz /tmp/
        cd /tmp/package-query
        sudo makepkg -si
        sudo rm -rf /tmp/package-query*

        # install yaourt
        wget -O /tmp/yaourt.tar.gz https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
        tar -xvzf /tmp/yaourt.tar.gz /tmp/
        cd /tmp/yaourt
        sudo makepkg -si
        sudo rm -rf /tmp/yaourt*
    fi
    yaourt -S archey2 conky-colors
else
    echo "Unknown linux distribution. Supported dists are Debian and Archlinux."
fi