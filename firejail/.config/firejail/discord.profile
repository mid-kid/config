whitelist ~/.firejail/discord

mkdir ~/.config/discord
noblacklist ~/.config/discord
whitelist ~/.config/discord

# discord-ipc...
mkdir /tmp/discord-ipc
whitelist /tmp/discord-ipc
env XDG_RUNTIME_DIR=/tmp/discord-ipc

# betterdiscord
mkdir ~/.local/share/betterdiscordctl
whitelist ~/.local/share/betterdiscordctl
mkdir ~/.config/BetterDiscord
whitelist ~/.config/BetterDiscord

ignore net none
ignore nodbus
ignore no3d
ignore novideo
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/default.inc
