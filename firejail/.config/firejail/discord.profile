whitelist ~/.firejail/discord

mkdir ~/.config/discord
noblacklist ~/.config/discord
whitelist ~/.config/discord

# discord-ipc...
whitelist /var/run
noblacklist /run/user

ignore net none
ignore nodbus
ignore no3d
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/default.inc
