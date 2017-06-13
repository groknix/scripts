#!/usr/bin/env python

import os
import time
import datetime

# 1. Get creation time on OSX,
#    use mtime on Linux
# 2. Convert floating point value to human
#    readable format
# 3. Reformat to preference (mine is Year,
#    Month, Day - Hour, Minute, Second)

def creation_time(file):
    ctime = os.stat(file).st_birthtime
    hr_time = datetime.datetime.fromtimestamp(ctime)
    timestamp = hr_time.strftime("-%Y%m%d_%H%M%S")
    return timestamp

