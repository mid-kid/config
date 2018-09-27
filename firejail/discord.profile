noblacklist ~/.local/opt/Discord
whitelist ~/.local/opt/Discord

mkdir ~/.config/discord
noblacklist ~/.config/discord
whitelist ~/.config/discord

protocol unix,inet,inet6,netlink
include ~/.config/firejail/default.profile
