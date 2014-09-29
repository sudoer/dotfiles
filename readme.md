
# my dot files

This git repo contains my "dot files" used to configure
stuff like my shell and editor.  I use these on Linux
and Mac OSX systems.  Since my multiple systems use the
same dot files, I get the same experience across all
machines.

On a typical machine, I will install this git repo in
a directory called **$HOME/.dotfiles**.  Then I create
symlinks to the actual files, like this:

    cd $HOME
    git clone git@github.com:sudoer/dotfiles.git .dotfiles
    # check to see if I am covering up something "good"
    diff .dotfiles/bashrc .bashrc
    mv .bashrc .bashrc.orig
    ln -s .dotfiles/bashrc .bashrc
    ... and so on...

When I make a change to a local dot file, I go into the
$HOME/.dotfiles directory and do my git commits and push
them up here so I can see that same change on my other
machines.

If you have questions or suggestions, feel free to send
them my way.

Alan Porter, alan@alanporter.com


PS - accessible via ssh or https

