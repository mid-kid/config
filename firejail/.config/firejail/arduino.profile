whitelist ~/.local/share/firejail/arduino

mkdir ~/.local/share/arduino
noblacklist ~/.local/share/arduino
whitelist ~/.local/share/arduino

whitelist ~/Stuff/Workspace/Arduino

# Required for esp8266 core...
#include allow-python2.inc
#include allow-python3.inc

ignore noroot
ignore private-dev
ignore net none
# STM32CubeProgrammer needs netlink
#protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/default.inc
