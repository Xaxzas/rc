#!/bin/bash
################################################################################
# rc files by XenGi                                                            #
# =================                                                            #
# use preinstall.sh to install needed packages                                 #
# see all files on github: https://github.com/XenGi/rc                         #
################################################################################

echo "welcome to the rc file install wizard"
echo "====================================="
echo

# server or desktop install
echo -n "Is this mashine running a GUI? [y/N]: "
read gui

if [[ "${gui,,}" -eq "y" ]] ; then
    GUI=true
else
    GUI=false
fi

# load helper scripts
source .bash_scripts

# install jdownloader desktop file
if [[ $GUI ]] ; then
    sudo cp ~/bin/jdownloader.desktop /usr/share/applications/
fi

# setup stuff for debian and raspbian
if [[ "`get_dristribution`" -eq "debian" -o "`get_dristribution`" -eq "raspbian" ]] ; then
    if [[ $GUI ]] ; then
        # add jdownloader menu entry
        sudo update-menus
    fi
    
    # update packages
    sudo apt-get update
    sudo apt-get upgrade
    
    # install needed packages
    sudo apt-get install dd pv less tree htop
    
    # setup debian specific stuff
    if [[ "`get_dristribution`" -eq "debian" ]] ; then
        # install things that work different on raspbian
        sudo apt-get install powertop lsb-release scrot
        if [[ $GUI ]] ; then
            #TODO: test if dependencies must be installed seperately
            #sudo apt-get install python-statgrab python-keyring ttf-ubuntu-font-family hddtemp curl lm-sensors conky-all
            sudo wget -O /tmp/archey-0.2.8.deb https://github.com/downloads/djmelik/archey/archey-0.2.8.deb
            sudo dpkg -i /tmp/archey-0.2.8.deb
            sudo rm -f /tmp/archey-0.2.8.deb
            sudo apt-get install -f
        fi
    # setup raspbian specific stuff
    else
        
        
    fi
# setup archlinux specific stuff
elif [[ "`get_dristribution`" -eq "archlinux" ]] ; then
    # update packages
    sudo pacman -Syu
    
    # install needed packages
    sudo pacman -S colordiff dd pv less tree htop powertop
    if [[ $GUI ]] ; then
        sudo pacman -S conky
    fi
    
    # test if yaourt is already installed and if not install it
    if [[ -z "`which yaourt`" ]] ; then
        # instal dependencies
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
    
    # install packages from AUR
    yaourt -S archey2
    yaourt -S pacman-color
    if [[ $GUI ]] ; then
        yaourt -S conky-colors
    fi
else
    echo "Unknown linux distribution. Supported dists are Debian, Raspbian and Archlinux."
fi
