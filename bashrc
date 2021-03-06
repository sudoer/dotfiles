# ~/.bashrc: executed by bash(1) for non-login shells.

################################################################################

# If this is a TOP-LEVEL & INTERACTIVE shell, then log everything.
if [[ ( -n "$PS1" ) && ( $ALAN_SHLVL -eq 0 ) && ( -z "$ALAN_SCRIPT_LOG" ) ]] ; then
    if [[ -d "$HOME/log/terminal" ]] ; then
        case $OSTYPE in
            linux-gnu*) scriptcmd=script ;;
            darwin*) scriptcmd=ttyrec ;;
        esac
        if type $scriptcmd > /dev/null 2>&1 ; then
            export ALAN_SCRIPT_LOG="terminal.$(date +%Y%m%d.%H%M%S).$$"
            echo "logging (via $scriptcmd) to $ALAN_SCRIPT_LOG"
            exec $scriptcmd "$HOME/log/terminal/$ALAN_SCRIPT_LOG"
        else
            echo "no console logging - could not find '$scriptcmd'"
            echo "path = $PATH"
        fi
    else
        #DEBUG export > $HOME/x.$$
        echo "no console logging"
    fi
fi

export ALAN_SHLVL=$(($ALAN_SHLVL+1))
export ALAN_HOME_BASHRC=1

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# an alternative: investigate http://unix.stackexchange.com/questions/25639/how-to-automatically-record-all-your-terminal-sessions-with-script-utility
# test "$(ps -ocommand= -p $PPID | awk '{print $1}')" == 'script' || (script -f $HOME/$(date +"%d-%b-%y_%H-%M-%S")_shell.log)

# PATH

function path_append () {
    add_me=$1
    # in bash v3, we could say this -> if [[ ! ":$PATH:" =~ ":$d:" ]] ; then
    [[ $(echo ":$PATH:" | grep -c ":$add_me:") -eq 0 ]] && [[ -d $add_me ]] && PATH="$PATH:$add_me"
    true
}

function path_prepend () {
    add_me=$1
    # in bash v3, we could say this -> if [[ ! ":$PATH:" =~ ":$d:" ]] ; then
    [[ $(echo ":$PATH:" | grep -c ":$add_me:") -eq 0 ]] && [[ -d $add_me ]] && PATH="$add_me:$PATH"
    true
}

################################################################################

# If not running interactively, don't do anything more
## [ -z "$PS1" ] && return

# This does the same thing
case "$-" in
    *i*) : ;; ## echo "interactive shell" ;;
    *)   return ;;
esac

################################################################################

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S  '
if [[ -d $HOME/.bash_history ]] ; then
    HISTFILE="$HOME/.bash_history/history.$(date +%Y%m%d.%H%M%S).$$"
else
    HISTFILE="$HOME/.bash_history"
fi
echo "saving shell history to $(basename $HISTFILE)"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(lesspipe)"

################################################################################

# COLOR

# TODO - do we need this? if [ "$TERM" != "dumb" ] ;

# ls
case $OSTYPE in
    linux-gnu*)
        if [ -f $HOME/.dircolors ] ; then
            eval "$(dircolors -b $HOME/.dircolors 2>/dev/null)"
        else
            eval "$(dircolors -b 2>/dev/null)"
        fi
        alias ls='ls --color=auto -F'
        ;;
    darwin*)
        export CLICOLOR=1
        export LSCOLORS="Dxfxcxdxbxegedabagacad"
        alias ls='/bin/ls -G'
        ;;
esac

# grep
alias grep='grep --devices=skip --color=auto'  # 'color=always' does bad things in scripts
export GREP_COLOR='1;31'

# less
export LESS='-R'

################################################################################

# PROMPT, ALIASES
[[ -f ~/.bash_colors ]]  && source ~/.bash_colors
[[ -f ~/.bash_prompt ]]  && source ~/.bash_prompt
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

################################################################################

# do these after bash_prompt, since they set $PROMPT_COMMAND

# History - save incremental history every time you can
shopt -s histappend
export PROMPT_COMMAND="$PROMPT_COMMAND ; history -w"

# On xterm-like shells, set the window and tab title bars EVERY TIME
# we draw the prompt.  This allows us to SSH into a box and the title will
# change, and then it will change back when we exit back to our local shell.
export PROMPT_COMMAND="$PROMPT_COMMAND ; draw_window_and_tab_titles"

################################################################################

# Make Control-v paste, if in X and if xclip available - Josh Triplett
if [[ -n "$DISPLAY" ]] && [[ -x /usr/bin/xclip ]] ; then
    # Work around a bash bug: \C-@ does not work in a key binding
    bind '"\C-x\C-m": set-mark'
    # The '#' characters ensure that kill commands have text to work on.
    # if not, this binding would malfunction at the start or end of a line.
    bind 'Control-v: "#\C-b\C-k#\C-x\C-?\"$(xclip -o -selection c)\"\e\C-e\C-x\C-m\C-a\C-y\C-?\C-e\C-y\ey\C-x\C-x\C-d"'
fi

################################################################################

# LOCALE

# Check 'man 7 locale'.
# The hierarchy of LC_ALL, LC_<whatever> and LANG is:
# LC_ALL overrides everything (if set to a non-null value).
# If LC_ALL is not used, then it checks the LC_ variables.
# If the specific one is not set, it checks LANG.
unset LC_ALL ; export LC_ALL ; :  # helps with utf8 chars
export LANG="en_US.UTF-8"         # for proper character sets on gcr
export LC_COLLATE="C"             # sort files in a unixy kind of way

################################################################################

# add these directories if they're not already in the path
path_append /usr/sbin
path_append /sbin
path_prepend $HOME/bin
path_prepend $HOME/.pyenv/bin  # if you have one

# homebrew on mac
case $OSTYPE in
    darwin*)
        type brew >/dev/null 2>&1
        if [[ $? -eq 0 ]] ; then
            path_prepend /usr/local/bin
            path_prepend /usr/local/opt/coreutils/libexec/gnubin
        fi
        ;;
esac

export PATH

################################################################################

# backspace
stty erase 

# command hash - caches locations of executables
# - use "hash -r" to rebuild
# - "set +h" to disable hashing
set +h

################################################################################

# OS-SPECIFIC STUFF

case $OSTYPE in
    linux-gnu)
        # some other app preferences
        export TSOCKS_CONF_FILE=$HOME/.tsocks.conf
        export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
        export VIRSH_DEFAULT_CONNECT_URI="qemu:///system"
        ;;
    darwin*)
        # turn off special handling of ._* files in tar, etc.
        export COPYFILE_DISABLE=1
        # bind HOME and END to reasonable escape sequences that work in vim, tmux and shell
        bind '"\e[1~":"\eOH"'
        bind '"\e[4~":"\eOF"'
        ;;
esac

################################################################################

# APP-SPECIFIC STUFF

# svn requires either EDITOR or SVN_EDITOR
export SVN_EDITOR=vim
export EDITOR=vim

## # tmux HOME/END keys
## if [[ -n "$TMUX" ]] ; then
##   bind '"\e[1~":"\eOH"'
##   bind '"\e[4~":"\eOF"'
## fi

################################################################################

# almost last - do local bashrc
[[ -f $HOME/.bashrc.local ]]   && source $HOME/.bashrc.local

