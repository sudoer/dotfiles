# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# Indicate that we've been here.
export ALAN_HOME_BASHPROFILE=1

# SHELL LEVEL - used by prompt, logout, logging
export ALAN_SHLVL=0

[[ -f ~/.bash_profile.local ]] && source ~/.bash_profile.local
[[ -d $HOME/.bash_profile.d ]] && source <(shopt -s nullglob ; cat $HOME/.bash_profile.d/* /dev/null)
#----------------------------------------

# Include .bashrc if it exists.
# Do this last, because my bashrc will do an 'exec script'
# to log all output (for top-level shells).
[[ -f ~/.bashrc ]] && source ~/.bashrc

