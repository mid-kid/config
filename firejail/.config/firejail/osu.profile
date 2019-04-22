whitelist ~/.firejail/osu

# discord...
whitelist /var/run
noblacklist /run/user

ignore net none
ignore no3d
include ~/.config/firejail/inc/wine.inc
