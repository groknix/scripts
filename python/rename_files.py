#!/usr/bin/env python

import os
import re
import glob
import time
import datetime

def creation_time(file):
    ctime = os.stat(file).st_birthtime
    hr_time = datetime.datetime.fromtimestamp(ctime)
    timestamp = hr_time.strftime("-%Y%m%d_%H%M%S")
    return timestamp

def clean_name(file):
    clean_name = re.sub(r'\s|\.|,|__', "_", file)
    clean_name = re.sub(r'_-_', "-", clean_name)
    #print clean_name # comment out or remove after testing
    return clean_name

for filename in os.listdir('.'):
    if filename.endswith(('.mp4', '.mv4', '.flv', '.png', '.jpg', '.jpeg', '.gif')):
        timestamp = creation_time(filename)
        file_name = os.path.splitext(filename)[0]
        extension = os.path.splitext(filename)[1]
        new_name = clean_name(file_name)
        new_file_name = new_name + timestamp + extension
        try:
            os.rename(filename, new_file_name)
        except OSError as e:
            print(e)
        else:
            print("Renamed {} to {}".format(filename, new_file_name))
