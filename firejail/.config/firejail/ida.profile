whitelist ~/.local/share/firejail/ida

whitelist ~/Stuff/Workspace/IDA
whitelist ~/Stuff/Workspace/hackthebox

# IDA seems to hate this one
blacklist /usr/share/fonts/noto-emoji

include ~/.config/firejail/inc/wine.inc
