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

ignore nodbus
include ~/.config/firejail/inc/electron.inc
