# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

export ALAN_HOME_BASHPROFILE=1

# the default umask is set in /etc/login.defs
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

################################################################################

# TEKELEC CLEARCASE STUFF - SHOULD BE LAST

# On clearcase machines, these scripts will overwrite some environment
# variables, like LANG="en_US" for xmerge to work properly.

cc=0
if rpm -q TPD-build-environ > /dev/null 2>&1 ; then
   # Don't look for clearcase on a build machine...
   # Some rocket scientist decided to mount ncna00a:/eng/tools/export_tklc
   # and so this script will find /usr/local/linux/cm/etc/ccase_setup.sh
   # on the build machine and it'll set a lot of environment variables
   # that inevitably screw up the build.
   echo "TPD build machine"
else
   for x in ./ccase_setup.sh /usr/local/linux/cm/etc/ccase_setup.sh /usr/local/cm/etc/ccase_setup.sh
   do
      if [ -r $x ] ; then
         echo "setting up clearcase [$x]"
         source $x
         cc=1
         # 'gcr' needs LANG="en_US" to work without truncating files
         export LANG="en_US"
         # HACK - ccollab needs to find a suitable Java VM -- it's here
         export INSTALL4J_JAVA_HOME="/export/home/eagle/sw_tools/java/linux/jre1.6.0_01"
         # see http://devtools.nc.tekelec.com/twiki/bin/view/EngTools/HowToSetupCodeCollab
         export PATH="$PATH:/usr/local/cm/java/bin"
         break  # we're done, don't look for more
      fi
   done
fi
if [ $cc -ne 0 ] ; then
   cleartool lsview | grep --color=always $USER
else
   echo "no clearcase setup"
fi

################################################################################

# fun
echo "welcome to $(hostname -s)"
echo -n "[0;33m" ; fortune 2> /dev/null ; echo -n "[00m"

# Include .bashrc if it exists.
# Do this last, because my bashrc will do an 'exec script'
# to log all output (for top-level shells).
[ -f ~/.bashrc ] && source ~/.bashrc

