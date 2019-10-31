whitelist ~/.firejail/arduino

mkdir ~/.arduino15
noblacklist ~/.arduino15
whitelist ~/.arduino15

mkdir ~/.jssc
whitelist ~/.jssc

whitelist ~/Stuff/Workspace/Arduino

# Required for esp8266 core...
noblacklist ${PATH}/python2*
noblacklist ${PATH}/python3*
noblacklist /usr/lib/python2*
noblacklist /usr/lib/python3*

ignore noroot
ignore private-dev
ignore net none
# STM32CubeProgrammer needs netlink
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/default.inc
