#!/usr/bin/env python

import os
import re


# strip out extraneous underscores/hyphens
# and convert punctuation and spaces to underscores
# equiv in shell:
# newfilename=$(echo "$oldfilename" | tr ' ' '_' | tr '.' '_' | tr ',' '_' | sed 's/_-_/-/g')

def clean_name(file):
    clean_name = re.sub(r'\s|\.|,|__', "_", file)
    clean_name = re.sub(r'_-_', "-", clean_name)
    #print clean_name # comment out or remove after testing 
    return clean_name

# Test for function above
for root, dirs, files in os.walk('.'):
    for filename in files:
        if filename.endswith(('.mp4', '.mv4', '.flv', '.png', '.jpg', '.jpeg', '.gif')): # add or subtract file types
            file_name = os.path.splitext(filename)[0]
            extension = os.path.splitext(filename)[1]
            new_name = clean_name(file_name)
            print new_name
