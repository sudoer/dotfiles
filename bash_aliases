
# common tools
alias vi='vim'
##OLD alias vpn='sudo echo "OK" ; sudo openvpn /etc/openvpn/buster-tekelec.conf'

# making crazy terminals sane again
alias kb='xset r rate 250 25'
alias rs='resize ; echo "stty rows $LINES columns $COLUMNS"'
alias reset="echo -e '\033c'"
##OLD alias reset="perl -e 'printf \"%cc\",27;'"

# git
alias gitlog='git log --abbrev=8 --abbrev-commit --date=short --pretty=format:"%h %ad %s"'
alias gitlog1='git log --pretty=oneline | head -20'
alias gitpullpush='git pull --rebase && git push'
#function gitrmdeleted () { git rm $(git status | grep '#\s*deleted:' | awk '{print $3}') }
alias gittree1="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gittree2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"

# VirtualBox
function vbox () {
   local vmname="$2"
   case "$1" in
      start)    { sh -xc "VBoxManage startvm \"$vmname\" --type headless" ; } ;;
      pause)    { sh -xc "VBoxManage controlvm \"$vmname\" savestate" ; } ;;
      stop)     { sh -xc "VBoxManage controlvm \"$vmname\" poweroff" ; } ;;
      list)     { sh -xc "VBoxManage list runningvms" ; } ;;
      all)      { sh -xc "VBoxManage list vms" ; } ;;
      *)        echo "vbox start|pause|stop|list|all" ;;
   esac
}

# virtual environments - native virtualenv
# stores environment in a local directory
function venv () {
   local name=${2:-venv}
   case "$1" in
      create) virtualenv $name ;;
      list)   ls -1 */bin/activate | sed -e 's|/.*$||g' ;;
      use)    source $name/bin/activate ;;
      exit)   deactivate ;;
      save)   pip freeze > $name.pip-pkgs ;;
      load)   pip install -r $name.pip-pkgs ;;
      *)      echo "venv create|list|use|save|load|exit" ;;
   esac
}

# script
alias script='script "script-$(date +%Y%m%d-%H%M%S)-$$"'
function endscript () {
   if [[ $(ps -ef | grep "$USER  *$PPID" | awk '{print $8}') == "script" ]] ; then
      echo "exiting 'script' session"
      exit
   else
      echo "not inside a 'script' session"
   fi
}

# homebrew on mac - man pages
case $OSTYPE in
    darwin*)
        type brew >/dev/null 2>&1
        if [[ $? -eq 0 ]] ; then
            # https://gist.github.com/quickshiftin/9130153
            # Short of learning how to actually configure OSX, here's a hacky way to use
            # GNU manpages for programs that are GNU ones, and fallback to OSX manpages otherwise
            # OR -- simply add `MANPATH_MAP /usr/local/opt/coreutils/libexec/gnubin /usr/local/opt/coreutils/libexec/gnuman` to /etc/man.conf
            alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1;  if [ "$?" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'
        fi
        ;;
esac

#-------------------------------------------------------------------------------

# window and tab titles

function window_title() { export WINDOW_TITLE="$*" ; }
function tab_title() { export TAB_TITLE="$*" ; }
function draw_window_and_tab_titles() {
    case "$TERM" in
    xterm*|rxvt*)
        # echo -ne "\033]X;text\007"  (where X=0: both, X=1: tab, X=2: window)
        # window title - only draw if it is set
        if [[ -n $WINDOW_TITLE ]] ; then
            echo -ne "\033]2;$WINDOW_TITLE\007"
        fi
        # tab title - draw whether it is set or not
        if [[ -n $TAB_TITLE ]] ;then
            echo -ne "\033]1;$TAB_TITLE\007"
        else
            echo -ne "\033]1;${USER}@${HOSTNAME%%.*}\007"
        fi
        ;;
    *)
        ;;
    esac
}

#-------------------------------------------------------------------------------

# other
alias colors='for c in $(seq 0 127) ; do echo -en "\033[${c}m$c\0033[0m\t" ; if [ $((c%10)) -eq 9 ] ; then echo "" ; fi ; done ; echo'
alias logterm="exec script \"$HOME/logs/terminal.\$(date +%Y%m%d.%H%M%S).\$$\""
alias rot13="gcipher -c Rot -k 13"
alias week='date +%V'
function do-over () { cmd=$* ; while true ; do date ; $cmd ; sleep 1 ; done }
function calc () { python -c "from math import *; print $*"; }
function daysince () { echo $(( ( $(date --date="12:00:00" +%s) - $(date --date="$1 12:00:00" +%s ) ) / 86400 + 1 )); }
function testmail () { to="$1" ; date | sh -xc "mail -s '$(date) ($(hostname))' $to" ; }
function sshloop () { to="$1" ; while true ; do date ; ssh $to ; sleep 2 ; done ; }
function nospace () { local x="$1" ; mv -v "$x" "${x// /_}" ; }
function nospaces () { for x in *\ * ; do mv -v "$x" "${x// /_}" ; done ; }
alias httpd='python -m SimpleHTTPServer'
function utc2local () { utc="$*"; date -d @$(TZ=UTC date +%s -d "$utc"); }

# fix my own mistakes
function scp() { if [[ "$@" =~ : ]] ; then /usr/bin/scp $@ ; else echo 'You forgot the colon!'; fi ; }

#-------------------------------------------------------------------------------
##
## # ssh wrapper that rename current tmux window to the hostname of the remote host.
## function ssh () {
##     # Do nothing if we are not inside tmux or ssh is called without arguments
##     local ssh_rc=0
##     if [[ -z $PS1 || -z $TMUX ]] ; then
##         $(which ssh) $@
##         ssh_rc=$?
##         return $ssh_rc
##     fi
##     # BIG ASSUMPTION - The hostname is the last parameter.
##     local remote="${@: -1}"
##     remote=${remote#*@}
##     local old_name="$(tmux display-message -p '#W')"
##     local renamed=0
##     # Save the current name
##     if [[ $remote != -* ]]; then
##         renamed=1
##         tmux rename-window $remote
##     fi
##     $(which ssh) $@
##     ssh_rc=$?
##     if [[ $renamed == 1 ]]; then
##         tmux rename-window "$old_name"
##     fi
##     return $ssh_rc
## }
##
#-------------------------------------------------------------------------------

# run ssh-add to ask for passphrase only when you run SSH
# http://beyond-syntax.com/blog/2012/01/on-demand-ssh-add/
alias ssh="( ssh-add -l > /dev/null || ( echo -n 'ssh-add/ssh-agent - ' ; ssh-add ) ) && ssh"

#-------------------------------------------------------------------------------

function ssh-reagent () {
   for agent in /tmp/ssh-*/agent.*; do
      export SSH_AUTH_SOCK=$agent
      if ssh-add -l 2>&1 > /dev/null; then
         echo Found working SSH Agent:
         ssh-add -l
         return
      fi
   done
   echo Cannot find ssh agent - maybe you should reconnect and forward it?
}

#-------------------------------------------------------------------------------

# platform-specific
case $OSTYPE in
   linux-gnu*)
      alias apt-upg='sudo apt-get update && sudo apt-get dist-upgrade'
      alias cdrecord='wodim'
      alias lvminfo='sudo pvs ; echo ; sudo vgs ; echo ; sudo lvs'
      alias netstatl='sudo lsof -i | grep LISTEN'
      function df () {
         # grep added to remove redundant line for rootfs
         /bin/df -Ph | grep -v '/by-uuid/.* /$' | awk '{printf "%-25s%8s%8s%8s%6s  %-20s\n", $1, $2, $3, $4, $5, $6}'
      }
      alias open='gio open'  # was 'xdg-open'
      alias pstree='ps xawf -eo pid,user,args'
      ;;
   darwin*)
      alias plistdump='plutil -convert xml1 -o - '
      alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
      alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
      alias macvim="open -a MacVim.app $*"
      ;;
esac


#-------------------------------------------------------------------------------

# http://raim.codingfarm.de/blog/2013/01/30/tmux-update-environment/
# re-evaluate SSH and DISPLAY parms without the leading dashes so X11 works
# See also http://readystate4.com/2011/03/31/refresh-a-stale-tmux-session/
function tmux() {

   local tmux=$(type -fp tmux)
   if [[ -z $tmux ]] ; then
      echo "tmux not installed"
      return
   fi

   case $OSTYPE in
      linux-gnu*)
         export TERM=xterm-256color
         ;;
   esac

   case "$1" in
      update-environment|env|x11)
         local v
         while read v; do
            if [[ $v == -* ]]; then
               unset ${v/#-/}
            else
               # Add quotes around the argument
               v=${v/=/=\"}
               v=${v/%/\"}
               eval export $v
            fi
         done < <(tmux show-environment)
         ;;
      *)
         $tmux "$@"
         ;;
   esac
}

#-------------------------------------------------------------------------------

# DIRECTORY BOOKMARKS
# http://stackoverflow.com/questions/7374534/directory-bookmarking-for-bash
function cdb() {
    USAGE="Usage: cdb [-c|-g|-d|-l] [bookmark]"
    if [[ ! -e ~/.cd_bookmarks ]] ; then mkdir ~/.cd_bookmarks ; fi
    if [[ $# -eq 0 ]] ; then echo "$USAGE" ; return 0 ; fi
    case $1 in
        # create bookmark
        -c) shift
            if [ ! -f "$HOME/.cd_bookmarks/$1" ] ; then
                echo "$(pwd)" > "$HOME/.cd_bookmarks/$1"
            else
                echo "Will not cover up existing bookmark '$1'"
            fi
            ;;
        # goto bookmark
        -g) shift
            if [ -f "$HOME/.cd_bookmarks/$1" ] ; then
                dir=$(cat "$HOME/.cd_bookmarks/$1")
                echo "$dir"
                cd "$dir"
            else
                echo "Bookmark '$1' does not exist."
            fi
            ;;
        # delete bookmark
        -d) shift
            if [ -f "$HOME/.cd_bookmarks/$1" ] ; then
                rm "$HOME/.cd_bookmarks/$1"
            else
                echo "Bookmark '$1' does not exist."
            fi
            ;;
        # list bookmarks
        -l) shift
            ( cd "$HOME/.cd_bookmarks/" ; shopt -s nullglob ; grep -v xyzzy * /dev/null )
            ;;
        # any other dashed arg = usage
        -*) echo "$USAGE"
            ;;
        # MOST-FREQUENT USE-CASE = undashed arg = goto bookmark
        *) cdb -g "$1"
            ;;
    esac
}

#-------------------------------------------------------------------------------

