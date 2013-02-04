# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If this is a TOP-LEVEL & INTERACTIVE shell, then log everything.
if [[ ( -n "$PS1" ) && ( $SHLVL -eq 1 ) && ( -z "$ALAN_SCRIPT_LOG" ) ]] ; then
   export ALAN_SCRIPT_LOG="terminal.$(date +%Y%m%d.%H%M%S).$$"
   if [[ -d "$HOME/logs" ]] ; then
      exec script "$HOME/logs/$ALAN_SCRIPT_LOG"
   else
      #DEBUG export > $HOME/x.$$
      echo "no console logging"
   fi
fi

export ALAN_HOME_BASHRC=1

################################################################################

# If not running interactively, don't do anything more
## [ -z "$PS1" ] && return

# This does the same thing
case "$-" in
*i*) echo "interactive shell" ;;
*)   return ;;
esac

################################################################################

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S  '

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

################################################################################

# COLOR

# 0   = default colour 1   = bold 4   = underlined 5   = flashing text 7   = reverse field
# 31  = red 32  = green 33  = orange 34  = blue 35  = purple 36  = cyan 37  = grey
# 40  = black bg 41  = red bg 42  = green bg 43  = orange bg 44  = blue bg 45  = purple bg 46  = cyan bg 47  = grey bg
# 90  = dark grey 91  = lt red 92  = lt green 93  = yellow 94  = lt blue 95  = lt purple 96  = turquoise
# 100 = dark grey bg 101 = lt red bg 102 = lt green bg 103 = yellow bg 104 = lt blue bg 105 = lt purple bg 106 = turquoise bg

case $OSTYPE in
   linux-gnu)
      if [ "$TERM" != "dumb" ]; then
         # ls
         if [ -f $HOME/.dircolors ] ; then
            eval "`dircolors -b $HOME/.dircolors 2>/dev/null`"
         else
            eval "`dircolors -b 2>/dev/null`"
         fi
         alias ls='ls --color=auto'
         # grep
         export GREP_OPTIONS='--color=auto'
         export GREP_COLOR='1;31'
         #AP alias grep='grep --color=always' # only use 'always' in interactive shells
         # less
         export LESS='-R'
      fi
      ;;
   darwin12)
      export LSCOLORS="Exfxcxdxbxegedabagacad"
      alias ls='ls -G'
      export GREP_OPTIONS='--color=auto'
      export GREP_COLOR='1;31'
      export LESS='-R'
      ;;
esac

################################################################################

# PROMPT, ALIASES
[ -f ~/.bash_prompt ]  && source ~/.bash_prompt
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bashrc.local ]   && source ~/.bashrc.local

################################################################################

# Make Control-v paste, if in X and if xclip available - Josh Triplett
if [ -n "$DISPLAY" ] && [ -x /usr/bin/xclip ] ; then
    # Work around a bash bug: \C-@ does not work in a key binding
    bind '"\C-x\C-m": set-mark'
    # The '#' characters ensure that kill commands have text to work on; if
    # not, this binding would malfunction at the start or end of a line.
    bind 'Control-v: "#\C-b\C-k#\C-x\C-?\"$(xclip -o -selection c)\"\e\C-e\C-x\C-m\C-a\C-y\C-?\C-e\C-y\ey\C-x\C-x\C-d"'
fi

################################################################################

# MISCELLANEOUS ENVIRONMENT

unset LC_ALL ; export LC_ALL ; :  # helps with utf8 chars
export LANG="en_US.UTF-8"         # for proper character sets on gcr
export LC_COLLATE="C"             # sort files in a unixy kind of way

# PATH

function path_append () {
   add_me=$1
   # in bash v3, we could say this -> if [[ ! ":$PATH:" =~ ":$d:" ]] ; then
   [ $(echo ":$PATH:" | grep -c ":$add_me:") -eq 0 ] && PATH="$PATH:$add_me"
}

function path_prepend () {
   add_me=$1
   # in bash v3, we could say this -> if [[ ! ":$PATH:" =~ ":$d:" ]] ; then
   [ $(echo ":$PATH:" | grep -c ":$add_me:") -eq 0 ] && PATH="$add_me:$PATH"
}

# add these directories if they're not already in the path
path_append /usr/sbin
path_append /sbin
path_prepend $HOME/bin
export PATH

################################################################################

# backspace
stty erase 

# one of these is required for svn
export SVN_EDITOR=vi
export EDITOR=vi
export BROWSER=/home/alan/bin/browser.sh

# some other app preferences
export TSOCKS_CONF_FILE=$HOME/.tsocks.conf
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export VIRSH_DEFAULT_CONNECT_URI="qemu:///system"

################################################################################

case $OSTYPE in
   linux-gnu)
      # DEBIAN PACKAGE DEVELOPER STUFF
      export DEBEMAIL="alan.porter@sentosa.us"
      export DEBFULLNAME="Alan Porter"
      ;;
esac

################################################################################



