#!/usr/bin/env python3
from sys import argv, stderr, exit
from os import environ
from os.path import isfile
from configparser import ConfigParser

filename = environ["HOME"] + "/.ssh/profiles"

if len(argv) < 2:
    print("Missing argument", file=stderr)
    exit(1)

if not isfile(filename):
    exit()

profiles = ConfigParser()
profiles.read(filename)

for profile in profiles:
    if profile == argv[1]:
        for info in profiles[profile]:
            if info == "hostname":
                print(profiles[profile][info], end=" ")
            elif info == "port":
                print("-p", profiles[profile][info], end=" ")
            elif info == "username":
                print("-l", profiles[profile][info], end=" ")
        exit()
