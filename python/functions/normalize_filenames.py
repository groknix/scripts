#!/usr/bin/env python

import os
import re
import glob
import fnmatch


# strip out extraneous underscores/hyphens
# and convert punctuation and spaces to underscores
# equiv in shell:
# newfilename=$(echo "$oldfilename" | tr ' ' '_' | tr '.' '_' | tr ',' '_' | sed 's/_rename..//g' | sed 's/_-_/-/g')

#for file in glob.glob('*.jpg,*.gif'):
#for files in os.listdir('.'):
for root, dirs, files in os.walk('.'):
    for filename in files:
        if filename.endswith(('.jpg', '.jpeg', '.gif')):
            file_name = os.path.splitext(filename)[0]
            extension = os.path.splitext(filename)[1]
            clean_name = re.sub(r'\s|\.|,|__', "_", file_name)
            clean_name = re.sub(r'_-_', "-", clean_name)
            print clean_name
