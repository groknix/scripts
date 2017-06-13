#
# Basic mail function
#
# Set some environment variables 
# so this works.
FQDN=`hostname -f`
LOG=/var/log/messages
MAIL=/usr/sbin/sendmail
DC=Some_unique_datacenter_id
RECIPIENTS="root"

# Function starts here
#

function report_mail()
{
$MAIL $RECIPIENTS <<EOF
subject:[$DC] Log rotation report
from:root@$FQDN
to:$RECIPIENTS
Log rotation script has completed in $DC.

`tail -40 $LOG`
EOF
}
