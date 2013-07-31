
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

# truecrypt
alias truecrypt="truecrypt --text"
alias tc="sudo truecrypt --text --auto-mount=favorites --keyfiles= --protect-hidden=no"
alias tcd="sudo truecrypt --text --dismount"

# other
alias age='echo $(( ( $(date --date="12:00:00" +%s) - $(date --date="9/20/1968 12:00:00" +%s ) ) / 86400 + 1 ))'
alias caching_days='echo $(( ( $(date +%s) - $(date --date="11/11/2006 0:00:00" +%s ) ) / 86400 + 1 ))'
alias colors='for c in $(seq 0 127) ; do echo -en "\033[${c}m$c\0033[0m\t" ; if [ $((c%10)) -eq 9 ] ; then echo "" ; fi ; done ; echo'
alias rot13="gcipher -c Rot -k 13"
function do-over () { cmd=$* ; while true ; do date ; $cmd ; sleep 1 ; done }
alias logterm="exec script \"$HOME/logs/terminal.\$(date +%Y%m%d.%H%M%S).\$$\""
alias script='script "script-$(date +%Y%m%d-%H%M%S)-$$"'
alias week='date +%V'
alias wiki="google-chrome --enable-file-cookies $HOME/SO/core/tiddlywiki/tklc-aporter.html"
alias twitter='twidge lsrecent | sed -e :a -e "$!N;s/\n  */ /;ta" -e "P;D"'
function calc() { python -c "from math import *; print $*"; }

# platform-specific
case $OSTYPE in
   linux-gnu*)
      alias apt-upg='sudo apt-get update && sudo apt-get dist-upgrade'
      alias cdrecord='wodim'
      alias lvminfo='sudo pvs ; echo ; sudo vgs ; echo ; sudo lvs'
      alias netstatl='sudo lsof -i | grep LISTEN'
      alias tmux='TERM=xterm-256color tmux'
      function df () {
         /bin/df -Ph | awk '{printf "%-25s%8s%8s%8s%6s  %-20s\n", $1, $2, $3, $4, $5, $6}'
      }
      ;;
   darwin*)
      alias plistdump='plutil -convert xml1 -o - '
      ;;
esac

