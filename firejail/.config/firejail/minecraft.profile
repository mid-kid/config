whitelist ~/.local/share/firejail/minecraft

mkdir ~/.minecraft
whitelist ~/.minecraft

mkdir ~/.ftblauncher
whitelist ~/.ftblauncher
mkdir ~/.ftb
whitelist ~/.ftb

ignore no3d
ignore net none
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/java.inc
