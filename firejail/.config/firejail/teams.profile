whitelist ~/.local/share/firejail/teams

mkdir ~/.config/Microsoft/Microsoft Teams
whitelist ~/.config/Microsoft/Microsoft Teams

ignore nodbus
include ~/.config/firejail/inc/electron.inc
