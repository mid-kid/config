whitelist ~/.local/share/firejail/teams

noblacklist ~/.config/Microsoft
mkdir ~/.config/Microsoft/Microsoft Teams
whitelist ~/.config/Microsoft/Microsoft Teams

private-bin readlink,dirname,mkdir,nohup

ignore nodbus
ignore novideo
ignore nosound
ignore seccomp
include ~/.config/firejail/inc/electron.inc
