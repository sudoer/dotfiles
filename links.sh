#!/bin/bash

for x in * ; do
    ext=${x#*.}
    [[ $ext = 'md' ]] && continue
    [[ $ext = 'sh' ]] && continue
    [[ -L $HOME/.$x ]] && rm -v $HOME/.$x
    [[ -f $HOME/.$x ]] && mv -v $HOME/.$x $HOME/.$x.orig
    ln -svf .dotfiles/$x $HOME/.$x
done

