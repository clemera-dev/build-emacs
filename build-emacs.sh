#!/bin/bash

# Build latest version of Emacs, version management with stow
# OS: Ubuntu 14.04 LTS and newer
# Toolkit: gtk3
# provide either version for official release
# or tar.xz url and dignature url for that

set -eu

# or tarball url and signature url
if [[ -n  "$2" ]]; then
  # urls for prereleases
  urlt="$1"
  # extract version
  version=$(basename -s .tar.xz "$urlt")
  version=${version/emacs-/}
  urls="$2"
else
  # 26.1
  version="$1"
  urlt=https://ftp.gnu.org/gnu/emacs/emacs-"$version".tar.xz
  urls=https://ftp.gnu.org/gnu/emacs/emacs-"$version".tar.xz.sig
fi

# install dependencies
sudo apt -q update
## default deps
# goto Software & Updates (software-properties-gtk) and enable Source Code repos
sudo apt -qy build-dep emacs

## script deps and libs
sudo apt -qy install wget stow atool build-essential

# anny additional libs for extra feaures
# man of them will included in the build for some you
# need to pass flags to configure, see INSTALL
sudo apt -qy install \
     libx11-dev libjpeg-dev libgif-dev libtiff5-dev libncurses5-dev \
     libxft-dev librsvg2-dev libmagickcore-dev libmagick++-dev \
     libxml2-dev libgpm-dev libotf-dev libm17n-dev \
     libgtk-3-dev libwebkitgtk-3.0-dev libxpm-dev libjansson-dev \
     libgnutls28-dev libpng-dev

# download build stuff
mkdir -p build
cd build
#
wget https://ftp.gnu.org/gnu/gnu-keyring.gpg
wget "$urlt"
wget "$urls"

gpg --verify --no-default-keyring --keyring ./gnu-keyring.gpg emacs-"$version".tar.xz.sig

# check and give chance to abort
read -p "Continue (y/n)?" choice
case "$choice" in
  y|Y ) : ;;
  * ) exit 1;;
esac


# extract and save extraction dir for make
mkdir -p build
cd build
> out
echo "Extracting......................................"
atool --save-outdir "./out" -x emacs-"$version".tar.xz

# compile
out=$(cat out)
cd "$out"
echo "Configure......................................"
./configure --with-modules --with-jansson

# setup stow dirs
sudo mkdir -p /usr/local/stow
# create needed /usr/local subdirectories
sudo mkdir -p /usr/local/{bin,etc,games,include,lib,libexec,man,sbin,share,src}

# install
echo "Installing...................................."
sudo chown -R clemera /usr/local/stow
make -j $(nproc) install prefix=/usr/local/stow/emacs-"$version"

# stowing
echo "$version read to stow..."
#cd /usr/local/stow
#stow emacs-"$version"







<<<<<<< HEAD
=======
# install
make install prefix=/usr/local/stow/emacs-"$version"

# cd /usr/local/stow
# sudo stow emacs-"$version"
>>>>>>> 55bd69a20688c282182162613798cb6e2f429e8c
