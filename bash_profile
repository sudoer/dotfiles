# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

export ALAN_HOME_BASHPROFILE=1
export ALAN_SHLVL=0

# the default umask is set in /etc/login.defs
#umask 022

# set PATH so it includes user's private bin if it exists
[[ -d ~/bin ]] && PATH="$HOME/bin:$PATH"

# local bash profile (before fun, to set up paths)
[[ -f ~/.bash_profile.local ]] && source ~/.bash_profile.local

# welcome, fun
echo "welcome to $(hostname -s)"
echo -en "\033[0;33m" ; fortune 2> /dev/null ; echo -en "\033[0;0m"

# status
tmux ls 2> /dev/null | sed -e 's/^/tmux: /g'
screen -ls 2> /dev/null | grep '^\s' | grep -v '^\s$' | sed -e 's/^\s*/screen: /g'

# Include .bashrc if it exists.
# Do this last, because my bashrc will do an 'exec script'
# to log all output (for top-level shells).
[[ -f ~/.bashrc ]] && source ~/.bashrc

