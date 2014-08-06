#!/bin/sh

AG=`which apt-get`
DPKG=`which dpkg`
MODLIST=( libdbd-mysql-perl libnet-ldap-perl libdbi-perl libdigest-perl libdigest-sha-perl libnet-snmp-perl libnetaddr-ip-perl libnet-rawip-perl libcrypt-cbc-perl libcrypt-des-perl nmap nbtscan )
PERL=`which perl`
CPAN=`which cpan`
countdown()
{
  countdown=${1:-5}   ## 5-second default
  w=${#countdown}
  while [ $countdown -gt 0 ]
  do
    sleep 1 &
    printf "  %${w}d\r" "$countdown"
    countdown=$(( $countdown - 1 ))
    wait
  done
  printf "\a"
} 2>/dev/null

for MOD in "${MODLIST[@]}"
  do echo -e "Checking for $MOD"
    $DPKG -l | grep $MOD > /dev/null
    XS=$?
    if [[ $XS = 0 ]] ; then
      echo "$MOD installed"
    else
      echo -e "\n$MOD missing, installing now...\n\n"
      $AG -yV install $MOD
      echo -e "\n\nContinuing in...\n\n"
       countdown
    fi
done
$PERL -MProc::Queue -e "print( \"Proc::Queue installed\n\" )"
    XS=$?
    if [[ $XS = 0 ]] ; then
      echo -e "\nAll perlmods are now installed!\n\n"
    else
      echo -e "\nProc::Queue needs to be installed\nthis will now be installed via cpan\nunless you abort now (CTL-C)\nsleeping for 5 seconds...\n"
      countdown
      echo -e "\nInstalling Proc::Queue via cpan...\n\n"
      $CPAN Proc::Queue
        XS=$?
        if [[ $XS = 0 ]] ; then
          echo -e "\nAll perlmods are now installed!\n\n"
        else 
          echo -e "Something went wrong, try re-running this script\nor installing manually\n"
        fi
    fi
