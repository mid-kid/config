whitelist ~/.firejail/ripcord

mkdir ~/.local/share/Ripcord
whitelist ~/.local/share/Ripcord

ignore net none
include ~/.config/firejail/inc/default.inc
