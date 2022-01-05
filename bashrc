# ~/.bashrc: executed by bash(1) for non-login shells.

# Indicate that we've been here.
export ALAN_HOME_BASHRC=1

# SHELL LEVEL - used by prompt, logout, logging
export ALAN_SHLVL=$(($ALAN_SHLVL+1))

# If not running interactively, don't do anything more
## [ -z "$PS1" ] && return

# This does the same thing
case "$-" in
    *i*) : ;; ## echo "interactive shell" ;;
    *)   return ;;
esac

# PATH - these functions are used in other bashrc.d/* scripts

function path_append () {
    local add_me=$1
    # in bash v3, we could say this -> if [[ ! ":$PATH:" =~ ":$d:" ]] ; then
    [[ $(echo ":$PATH:" | grep -c ":$add_me:") -eq 0 ]] && [[ -d $add_me ]] && PATH="$PATH:$add_me"
    true
}

function path_prepend () {
    local add_me=$1
    # in bash v3, we could say this -> if [[ ! ":$PATH:" =~ ":$d:" ]] ; then
    [[ $(echo ":$PATH:" | grep -c ":$add_me:") -eq 0 ]] && [[ -d $add_me ]] && PATH="$add_me:$PATH"
    true
}

export PATH

# add these directories if they're not already in the path
path_append /usr/sbin
path_append /sbin
path_prepend $HOME/bin

# An array of functions to call on each prompt.
# Be careful not to put slow stuff in here.
# $PROMPT_COMMAND is interpreted by the shell, $PROMPT_COMMANDS is an associative array.
declare -A PROMPT_COMMANDS

# An array of bits to add to the shell prompt.
declare -A PROMPT_PIECES

# almost last - do local bashrc
[[ -f $HOME/.bashrc.local ]] && source $HOME/.bashrc.local
[[ -d $HOME/.bashrc.d ]] && source <(shopt -s nullglob ; cat $HOME/.bashrc.d/* /dev/null)

