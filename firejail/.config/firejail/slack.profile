whitelist ~/.local/share/firejail/slack

mkdir ~/.config/Slack
noblacklist ~/.config/Slack
whitelist ~/.config/Slack

ignore nodbus
include ~/.config/firejail/inc/electron.inc
