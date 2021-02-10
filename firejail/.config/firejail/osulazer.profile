whitelist ~/.local/share/firejail/osulazer

mkdir ~/.local/share/osu
whitelist ~/.local/share/osu

# discord-ipc...
mkdir /tmp/discord-ipc
whitelist /tmp/discord-ipc
env XDG_RUNTIME_DIR=/tmp/discord-ipc

whitelist ~/Baixades

# firefox sandbox ecaping (ease of downloading songs)...
noblacklist ~/.mozilla
whitelist ~/.mozilla

ignore net none
ignore no3d
ignore nosound
# TODO: What syscalls?
ignore seccomp
include ~/.config/firejail/inc/discord-ipc.inc
include ~/.config/firejail/inc/default.inc
