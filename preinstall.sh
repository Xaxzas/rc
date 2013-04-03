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
read -p "==> Is this mashine running a GUI? [y/N]: "

# load helper scripts
source .bash_scripts

# install jdownloader desktop file
if [[ "$REPLY" == "y" ]] ; then
    echo "==> Adding jDownloader menu entry"
    sudo cp bin/jdownloader.desktop /usr/share/applications/
fi

distribution="`get_distribution`"
echo "==> Detected distribution: $distribution"
if [[ "$distribution" == "unknown" ]] ; then
    echo "==> Unknown linux distribution. Supported dists are Debian, Raspbian and Archlinux."
    exit
fi


# setup stuff for debian and raspbian
if [[ "$distribution" == "debian" ]] || [[ "$distribution" == "raspbian" ]] ; then
    if [[ "$REPLY" == "y" ]] ; then
        # add jdownloader menu entry
        echo "==> Updating menu"
        sudo update-menus
    fi

    # update packages
    echo "==> Updating packages"
    sudo apt-get update
    sudo apt-get upgrade

    # install needed packages
    echo "==> Installing new packages"
    sudo apt-get install coreutils pv less tree htop colordiff

    # setup debian specific stuff
    if [[ "$distribution" == "debian" ]] ; then
        # install things that work different on raspbian
        echo "==> Installing new packages"
        sudo apt-get install powertop lsb-release scrot
        if [[ "$REPLY" == "y" ]] ; then
            echo "==> Downloading and installing archey"
            #TODO: test if dependencies must be installed seperately
            #sudo apt-get install python-statgrab python-keyring ttf-ubuntu-font-family hddtemp curl lm-sensors conky-all
            sudo wget -O /tmp/archey-0.2.8.deb https://github.com/downloads/djmelik/archey/archey-0.2.8.deb
            sudo dpkg -i /tmp/archey-0.2.8.deb
            sudo rm -f /tmp/archey-0.2.8.deb
            sudo apt-get install -f
        fi
    # setup raspbian specific stuff
    else
        echo "==> Doing Raspbian specific stuff"

    fi
# setup archlinux specific stuff
elif [[ "$distribution" == "archlinux" ]] ; then
    # update packages
    echo "==> Updating packages"
    sudo pacman -Syu

    # install needed packages
    echo "==> Installing new packages"
    sudo pacman -S colordiff coreutils pv less tree htop powertop

    # test if yaourt is already installed and if not install it
    if [[ -z "`which yaourt`" ]] ; then
        # install dependencies
        echo "==> Installing dependencies for yaourt"
        sudo pacman -S base-devel

        # install package-query
        echo "==> Installing package-query"
        wget -O /tmp/package-query.tar.gz https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
        tar -xvzf /tmp/package-query.tar.gz /tmp/
        cd /tmp/package-query
        sudo makepkg -si
        sudo rm -rf /tmp/package-query*

        # install yaourt
        echo "==> Installing yaourt"
        wget -O /tmp/yaourt.tar.gz https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
        tar -xvzf /tmp/yaourt.tar.gz /tmp/
        cd /tmp/yaourt
        sudo makepkg -si
        sudo rm -rf /tmp/yaourt*
    fi

    # install packages from AUR
    echo "==> Installing new packages"
    yaourt -S archey2
    yaourt -S pacman-color
    if [[ "$REPLY" == "y" ]] ; then
        yaourt -S conky-colors
    fi
fi

# copy the right files to home dir
echo "==> Copying new rc files to user dir"
cp -v .bash_logout .bashrc .bash_aliases .bash_scripts .profile ~/
mkdir ~/bin
cp -v bin/dede bin/proxyon bin/fhb_proxy.sh bin/proxyoff bin/wol ~/bin/
if [[ "$distribution" == "raspbian" ]] ; then
    cp -v bin/pi_motd ~/bin/
fi
if [[ "$REPLY" == "y" ]] ; then
    cp -rv .conkycolors ~/
    cp -v bin/gnome_startup.sh bin/jdownloader bin/jdownloader.svg ~/bin/
fi
echo "==> Setup complete. Enjoy your new system!"
