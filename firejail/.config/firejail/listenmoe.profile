whitelist ~/.local/share/firejail/listenmoe

mkdir ~/.config/listen.moe-desktop-app
whitelist ~/.config/listen.moe-desktop-app

ignore nosound
ignore dbus-user none
include ~/.config/firejail/inc/electron.inc
