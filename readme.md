
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
    git clone https://github.com/sudoer/dotfiles.git .dotfiles
    # check to see if I am covering up something "good"
    diff .dotfiles/bashrc .bashrc
    mv .bashrc .bashrc.orig
    ln -s .dotfiles/bashrc .bashrc
    ... and so on...

There is a script called `links.sh` that makes these
symlinks for me automatically.

When I make a change to a local dot file, I go into the
$HOME/.dotfiles directory and commit the changes and push
them up to github so the changes can be pulled down to all
of the other systems that I use.

Some dotfiles, like .bash_profile and .bashrc, sometimes
need a local-only change that is not shared with other
machines.  In those cases, I typically "include" a local
file called .bash_profile.local or .bashrc.local.

If you have questions or suggestions, feel free to send
them my way.

Alan Porter, alan@alanporter.com


