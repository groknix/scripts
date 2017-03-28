#! /bin/bash

# This script checks root's mail
# in /var/mail/ and returns a line
# count.  This could also be done
# with 'mail -H' but mailutils would
# have to be installed on the host.
# This is easy to have Nagios run.

# Set the warn and critical thresholds
WARN=1000
CRITICAL=10000

usage(){
echo "Usage: $0 [-W <number of emails to warn>] [-C <number of emails, critical>]"
echo "Usage: $0 -W100 -C5000  (will warn when messages reach 100 and critical at 5000)"
echo "No Options: defaults to warn at 1000 and critical at 10,000 "
exit 1
}

while getopts W:C: option
do
  case "$option"
  in
    W)  WARN=$OPTARG;;
    C)  CRITICAL=$OPTARG;;
    \?)  usage
       exit 1;;
  esac
done
shiftcount=`expr $OPTIND - 1`
shift $shiftcount

# Check for the existence of mailbox file
if [ ! -f /var/mail/root ]
  then exit 0

# See how many messages there are
  else
    COUNT=`sudo /bin/cat /var/mail/root | grep Subject | wc -l`
fi

# Now check to see if we hit either threshold
if [ $COUNT -gt $CRITICAL ]; then
  echo "CRITICAL - There are $COUNT messages in root's mailbox"
  exit 1
  else
    if [ $COUNT -gt $WARN ]; then
      echo "WARN - There are $COUNT messages in root's mailbox"
    else
      echo "OK - There are $COUNT messages in root's mailbox"
    fi
fi
