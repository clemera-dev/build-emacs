#!/bin/bash

# Build latest version of Emacs, version management with stow
# OS: Ubuntu 14.04 LTS and newer
# Toolkit: gtk3

set -eu

# the home for setup
mkdir -p "$HOME/.emacs.d"
cd "$HOME/.emacs.d"


# readonly 26.1
version="$1"

# install dependencies
sudo apt -q update
## default deps
## sudo apt build-dep emacs
## optional stuff and stow
sudo apt -qy install wget stow build-essential \
     libx11-dev libjpeg-dev libgif-dev libtiff5-dev libncurses5-dev \
     libxft-dev librsvg2-dev libmagickcore-dev libmagick++-dev \
     libxml2-dev libgpm-dev libotf-dev libm17n-dev \
     libgtk-3-dev libwebkitgtk-3.0-dev libxpm-dev libjansson-dev\
     libgnutls28-dev libpng-dev

# get emacs tarball
if [[ ! -d emacs-"$version" ]]; then

   wget https://ftp.gnu.org/gnu/gnu-keyring.gpg
   wget https://ftp.gnu.org/gnu/emacs/emacs-"$version".tar.xz
   wget https://ftp.gnu.org/gnu/emacs/emacs-"$version".tar.xz.sig

   gpg --verify --no-default-keyring --keyring ./gnu-keyring.gpg emacs-"$version".tar.xz.sig

   read -p "Continue (y/n)?" choice
   case "$choice" in
       y|Y ) : ;;
       * ) exit 1;;
   esac

   tar xvf emacs-"$version".tar.xz

fi

# create needed /usr/local subdirectories
sudo mkdir -p /usr/local/{bin,etc,games,include,lib,libexec,man,sbin,share,src}
# setup stow dirs
sudo mkdir -p /usr/local/stow
sudo chown -R clemera /usr/local/stow

cd emacs-"$version"
./configure \
    --with-xft \
    --with-x-toolkit=gtk3\
    --with-modules

# install
make install prefix=/usr/local/stow/emacs-"$version"

# cd /usr/local/stow
# sudo stow emacs-"$version"
