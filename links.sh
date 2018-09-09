#!/bin/bash
thisdir=$(realpath --relative-to $HOME $(pwd))
if [[ $? -ne 0 || $thisdir == '' ]] ; then
    # realpath failed
    thisdir=$(basename $(pwd))
fi
for dotfile in $(find * -type f) ; do
    base=$(basename $dotfile)
    dir=$(dirname $dotfile)
    ext=${base#*.}
    [[ $ext = 'md' ]] && continue
    [[ $ext = 'sh' ]] && continue
    [[ $dir != '.' && ! -d $HOME/.dir ]] && mkdir -p $HOME/.$dir
    [[ -L $HOME/.$dotfile ]] && rm -v $HOME/.$dotfile
    [[ -f $HOME/.$dotfile ]] && mv -v $HOME/.$dotfile $HOME/.$dotfile.orig
    backdots=''
    [[ $dir != '.' ]] && backdots="${dir//*/..}/" 
    ln -svf $backdots$thisdir/$dotfile $HOME/.$dotfile
done

