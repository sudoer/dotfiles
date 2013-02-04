
# common tools
alias vi='vim'
alias vpn='sudo echo "OK" ; sudo openvpn /etc/openvpn/buster-tekelec.conf'

# making crazy terminals sane again
alias kb='xset r rate 250 25'
alias rs='resize ; echo "stty rows $LINES columns $COLUMNS"'
alias reset="perl -e 'printf \"%cc\",27;'"

# git
alias glog='git log --pretty=oneline | head -20'

# other
alias caching_days='echo $(( ( $(date +%s) - $(date --date="11/11/2006 0:00:00" +%s ) ) / 86400 + 1 ))'
alias colors='for c in $(seq 0 127) ; do echo -en "\033[${c}m$c\0033[0m\t" ; if [ $((c%10)) -eq 9 ] ; then echo "" ; fi ; done ; echo'
alias rot13="gcipher -c Rot -k 13"
alias update="sudo apt-get update && sudo apt-get dist-upgrade"
function do-over () { cmd=$* ; while true ; do date ; $cmd ; sleep 1 ; done }
alias log="exec script \"$HOME/logs/terminal.\$(date +%Y%m%d.%H%M%S).\$$\""
alias script='/usr/bin/script "script-$(date +%Y%m%d-%H%M%S)-$$"'
alias week='date +%V'
alias wiki='google-chrome --enable-file-cookies file:///media/truecrypt1/tiddlywiki/tklc-aporter.html'
alias twitter='twidge lsrecent | sed -e :a -e "$!N;s/\n  */ /;ta" -e "P;D"'
function calc() { python -c "from math import *; print $*"; }


