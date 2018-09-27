noblacklist ~/.local/opt/steam
whitelist ~/.local/opt/steam

mkdir ~/.steam
noblacklist ~/.steam
whitelist ~/.steam

mkdir ~/.local/share/Steam
noblacklist ~/.local/share/Steam
whitelist ~/.local/share/Steam

noblacklist ~/.steampath
whitelist ~/.steampath
noblacklist ~/.steampid
whitelist ~/.steampid

# Random games that use different folders
noblacklist ~/.local/share/Daedalic Entertainment
whitelist ~/.local/share/Daedalic Entertainment
noblacklist ~/.config/unity3d
whitelist ~/.config/unity3d

protocol unix,inet,inet6,netlink
include ~/.config/firejail/default.profile
