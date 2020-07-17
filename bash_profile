# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

export ALAN_HOME_BASHPROFILE=1
export ALAN_SHLVL=0

# the default umask is set in /etc/login.defs
#umask 022

# set PATH so it includes user's private bin if it exists
[[ -d ~/bin ]] && PATH="$HOME/bin:$PATH"

# very basic welcome
echo "welcome to ${HOSTNAME%%.*}"

# KDE konsole terminal only looks at WINDOW_TITLE
# Mac iTerm2 respects WINDOW_TITLE and TAB_TITLE
export WINDOW_TITLE="$USER@${HOSTNAME%%.*}"
export TAB_TITLE="$USER@${HOSTNAME%%.*}"

#----------------------------------------
# run local bash profile, if it exists
# STUFF I LIKE TO DO IN .bash_profile.local :
# - MACHINE STATS
#   uptime
# - FORTUNE
#   echo -en "\033[0;33m" ; fortune 2> /dev/null ; echo -en "\033[0;0m"
# - NETWORK STATS
#   vnstat -m --style 1
#   vnstat -d --style 1 | head -5 ; vnstat -d --style 1 | tail -10
# - TMUX/SCREEN/VIRTUALBOX STATUS
#   tmux ls 2> /dev/null | sed -e 's/^/tmux: /g'
#   screen -ls 2> /dev/null | grep '^\s' | grep -v '^\s$' | sed -e 's/^\s*/screen: /g'
#   VBoxManage list runningvms | sed -e 's/^/vbox: /g'
# - cat /var/run/reboot-required and /var/run/reboot-required.pkgs
[[ -f ~/.bash_profile.local ]] && source ~/.bash_profile.local
#----------------------------------------

# Include .bashrc if it exists.
# Do this last, because my bashrc will do an 'exec script'
# to log all output (for top-level shells).
[[ -f ~/.bashrc ]] && source ~/.bashrc

