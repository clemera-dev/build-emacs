Helper script for Emacs compilation on Ubuntu using official tarball releases...

Ativate sytemd service:
   
       systemctl --user enable --now emacs
       
Then you can Emacs invoke `emacsclient -c <args>` by binding it to a key.
If you need to restart Emacs use:

    systemctl --user restart emacs.
