
# common tools
alias vi='vim -o'
alias vim='vim -o'
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
function vbox_start { sh -xc "VBoxManage startvm $1 --type headless" ; }
function vbox_pause { sh -xc "VBoxManage controlvm $1 savestate" ; }
function vbox_stop  { sh -xc "VBoxManage controlvm $1 poweroff" ; }

# truecrypt
alias truecrypt="truecrypt --text"
alias tc="sudo truecrypt --text --auto-mount=favorites --keyfiles= --protect-hidden=no"
alias tcd="sudo truecrypt --text --dismount"

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

# other
alias colors='for c in $(seq 0 127) ; do echo -en "\033[${c}m$c\0033[0m\t" ; if [ $((c%10)) -eq 9 ] ; then echo "" ; fi ; done ; echo'
alias logterm="exec script \"$HOME/logs/terminal.\$(date +%Y%m%d.%H%M%S).\$$\""
alias rot13="gcipher -c Rot -k 13"
alias week='date +%V'
function do-over () { cmd=$* ; while true ; do date ; $cmd ; sleep 1 ; done }
function calc () { python -c "from math import *; print $*"; }
function daysince () { echo $(( ( $(date --date="12:00:00" +%s) - $(date --date="$1 12:00:00" +%s ) ) / 86400 + 1 )); }
function testmail () { to="$1" ; date | sh -xc "mail -s 'from $(hostname) $(date)' $to" ; }

# fix my own mistakes
function scp() { if [[ "$@" =~ : ]] ; then /usr/bin/scp $@ ; else echo 'You forgot the colon!'; fi ; }

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
         /bin/df -Ph | awk '{printf "%-25s%8s%8s%8s%6s  %-20s\n", $1, $2, $3, $4, $5, $6}'
      }
      alias open='xdg-open'
      ;;
   darwin*)
      alias plistdump='plutil -convert xml1 -o - '
      alias date='gdate'
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

