whitelist ~/.firejail/osu

# discord...
mkdir /tmp/discord-ipc
whitelist /tmp/discord-ipc
env XDG_RUNTIME_DIR=/tmp/discord-ipc

# firefox sandbox ecaping (ease of downloading songs)...
noblacklist ~/.mozilla
whitelist ~/.mozilla

ignore net none
ignore no3d
include ~/.config/firejail/inc/wine.inc
