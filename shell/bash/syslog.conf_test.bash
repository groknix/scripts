#!/bin/bash

# This is a simple script to test
# your rsyslog.conf rules to ensure
# they are ending up in the correct
# logfile in /var/log

# Standard facility names:
#
# auth
# authpriv
# cron
# daemon
# ftp
# kern (can't be generated from user process)
# lpr
# mail
# news
# security (deprecated synonm for auth)
# syslog
# user
# uucp
# local0
# local1
# local2
# local3
# local4
# local5
# local6
# local7

# Standard level names:
# (in order of decreasing importance)
#
# emerg
# alert
# crit
# err
# warning
# notice
# info
# debug
#

# Set the facility and levels you need to test here:
FACILITIES=( auth authpriv cron daemon mail syslog user local0 local1 local2 local3 local4 local5 local6 local7 )
LEVELS=( emerg alert crit err warning notice info debug )

# begin testing
for FACILITY in ${FACILITIES[@]}; do
  echo -e "\n\n\nTesting $FACILITY syslog facility for all levels...\n"
  sleep 2
  echo -e "\nTesting loglines as follows:\n"
  sleep 1
  for LEVEL in ${LEVELS[@]}; do
    echo -e "sending $FACILITY.$LEVEL test line...\n"
    logger -p $FACILITY.$LEVEL -t [syslog.conf.test] "testing $FACILITY.$LEVEL.$$" 
    echo -e "Checking /var/log for all instances of test line...\n"
    sudo find /var/log -maxdepth 3 -type f  -exec sudo grep -H $FACILITY.$LEVEL.$$ {} \; | grep -iv sudo
    echo -e "\n\n"
    sleep 2
  done
  echo -e "\nDone testing all levels for $FACILITY...\n"
  echo -e "\n****************************************\n"
  echo -e "\n****************************************\n"
  sleep 5
done
echo -e "\nAll tests complete, please check logfiles.\n"
