whitelist ~/.firejail/clonehero

# discord-ipc...
mkdir /tmp/discord-ipc
whitelist /tmp/discord-ipc
env XDG_RUNTIME_DIR=/tmp/discord-ipc

mkdir ~/.config/unity3d/srylain Inc_/Clone Hero
whitelist ~/.config/unity3d/srylain Inc_/Clone Hero

ignore net none
ignore no3d
ignore seccomp
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/default.inc
