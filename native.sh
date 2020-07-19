#!/bin/env bash
git checkout feature/native-comp
./autogen.sh
./configure  --with-gnutls --without-gconf --with-rsvg --with-x --with-xwidgets --without-toolkit-scroll-bars --without-xaw3d --without-gsettings --with-mailutils --with-nativecomp CFLAGS="-O3 -mtune=native -march=native -fomit-frame-pointer"
# (native-compile-async "~/.emacs.d/elpa/" 4 t)
# See also https://github.com/mnewt/dotemacs/blob/master/bin/build-gccemacs
