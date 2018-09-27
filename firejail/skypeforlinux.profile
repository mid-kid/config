noblacklist ~/.local/opt/skypeforlinux
whitelist ~/.local/opt/skypeforlinux

mkdir ~/.config/skypeforlinux
noblacklist ~/.config/skypeforlinux
whitelist ~/.config/skypeforlinux

protocol unix,inet,inet6,netlink
include ~/.config/firejail/default.profile
