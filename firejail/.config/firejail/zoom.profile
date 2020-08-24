whitelist ~/.local/share/firejail/zoom

mkfile ~/.config/zoomus.conf
whitelist ~/.config/zoomus.conf
mkdir ~/.cache/zoom
whitelist ~/.cache/zoom
mkdir ~/.zoom
whitelist ~/.zoom

ignore novideo
ignore net none
include ~/.config/firejail/inc/default.inc
