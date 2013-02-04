
# common tools
alias vi='vim'
alias vpn='sudo echo "OK" ; sudo openvpn /etc/openvpn/buster-tekelec.conf'
alias win='rdesktop -g 1152x864 -a 16 -u aporter nc1pc1067a.local'
alias cc='sshfs -o uid=$(id -u) aporter@nclde01:/view ~/mnt/cc'

# making crazy terminals sane again
alias kb='xset r rate 250 25'
alias rs='resize ; echo "stty rows $LINES columns $COLUMNS"'
alias reset="perl -e 'printf \"%cc\",27;'"

# common paths
alias godsr='cd /view/$CUR_CT_VIEW/vobs/software/dsr'
alias goawpss7='cd /view/$CUR_CT_VIEW/vobs/software/awpss7'

# build stuff
alias entropy='for x in $(seq 1 500) ; do echo -n "." ; find / -xdev -ls > /dev/null 2>&1 ; done ; echo'

# appworks
# DOES NOT WORK - both machines are on the remote side -> alias hulk='ssh -i /home/alan/.ssh/id_rsa -R 80:10.10.2.30:80 -R 443:10.10.2.30:443 -g root@hulkster'
alias hulk='sudo ssh -i /home/alan/.ssh/id_rsa -L 80:10.10.2.30:80 -L 443:10.10.2.30:443 -g root@hulkster'

# git
alias glog='git log --pretty=oneline | head -20'

# tools at Tekelec
alias slick='/usr/local/linux/utils/vslick/bin/vs'

# work on my PC
alias gui='cd ~/work/dsr4/awpss7/diameter/TKLCdpi/gui'

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

#-------------------------------------------------------------------------------

function buildScript () {

   # optional - use this if someone has changed the kernel and we're tired of building it
   ## excludes="--excludeSRPM=kernel"

   # To build just your BCR, you want this:
   ## c0="buildRPMS --release=0.18555 TPD.install"

   # This command builds any RPM's that match the current "release" (example 3.1.0_61.12.0").
   # Normally, when working on a BCR, nothing would be built here.
   c1="buildRPMS $excludes --nosend TPD.install"

   # This command builds everything in the package lists that have 0.12345 BCR numbers.
   # This builds everything that you are working on, as well as everything the rest of
   # the developers have worked on since the last official build.
   c2="buildRPMS $excludes --nosend --buildByBCR TPD.install"

   # This command put all of the RPMS onto an installation CDROM.
   c3="buildDistro TPD.install"

   logfilename="$HOME/build.$(hostname -s).$(date +%F.%T)"

   # Now do all of the work, and record it all to a log file.
               command="date && echo \"ALAN: $c1\" && $c1"
   command="$command && date && echo \"ALAN: $c2\" && $c2"
   command="$command && date && echo \"ALAN: $c3\" && $c3"
   echo "RUNNING [$command]"
   script -c "$command" $logfilename

}

#-------------------------------------------------------------------------------

alias truecrypt="/usr/local/bin/truecrypt --text"
unalias tc 2> /dev/null
function tc () {
   # all potential sources of truecrypt data
   local sources=""
   # find potential block devices
   local blockdev=""
   blockdev=$(sudo fdisk -l 2>&1 | grep "doesn't contain a valid partition table" | sed 's/^.*Disk/Disk/g' | awk "{print \$2}" | tr '\n' ' ')
   for device in $blockdev ; do
       if [[ ! ( $(readlink -f "/sys/block/$(basename $device)") =~ /.*\/virtual\/.*/ ) ]] ; then
           sources="$sources $device"
       fi
   done
   # find potential partitions
   local parts=""
   parts=$(sudo fdisk -l 2>&1 | grep "Non-FS data" | awk "{print \$1}" | tr '\n' ' ')
   sources="$sources $parts"
   # find potential files
   for mountpoint in $(mount | awk '{print $3}') ; do
       files=$(ls -1 $mountpoint/*.tc 2>/dev/null)
       sources="$sources $files"
   done
   # cleanup
   sources=$(echo $sources | sed 's/  */ /g')
   # ask for passwords and mount 'em up!
   local slot=1
   echo "devices found: $sources"
   for source in $sources ; do
      cmd="sudo /usr/local/bin/truecrypt --text --keyfiles= --protect-hidden=no --slot=$slot $source /media/truecrypt$slot"
      echo "$cmd"
      $cmd
      if [[ $? -eq 0 ]] ; then slot=$(( $slot + 1 )) ; fi
   done
}
alias tcd='cd ; sudo truecrypt -t -d'

#-------------------------------------------------------------------------------


