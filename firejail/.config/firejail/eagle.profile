whitelist ~/.firejail/eagle

#mkfile ~/.~~~
#whitelist ~/.~~~
#mkfile ~/.eaglerc
#whitelist ~/.eaglerc

mkdir ~/.config/Autodesk
whitelist ~/.config/Autodesk
mkdir ~/.local/share/Eagle
whitelist ~/.local/share/Eagle

whitelist ~/Stuff/Workspace/Eagle

ignore net none
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/default.inc
