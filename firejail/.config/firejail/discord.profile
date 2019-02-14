whitelist ~/.firejail/discord

mkdir ~/.config/discord
noblacklist ~/.config/discord
whitelist ~/.config/discord

ignore net none
ignore nodbus
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/default.inc
