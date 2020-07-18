#!/bin/env bash
git checkout feature/native-comp
./autogen.sh
./configure  --with-gnutls --without-gconf --with-rsvg --with-x --with-xwidgets --without-toolkit-scroll-bars --without-xaw3d --without-gsettings --with-mailutils --with-nativecomp CFLAGS="-O3 -mtune=native -march=native -fomit-frame-pointer"
