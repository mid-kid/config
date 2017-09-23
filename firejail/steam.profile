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

#nodvd
#nogroups
#notv
#novideo
protocol unix,inet,inet6,netlink
#shell none
#private-dev
#private-etc asound.conf,ca-certificates,dbus-1,drirc,fonts,group,gtk-2.0,gtk-3.0,host.conf,hostname,hosts,ld.so.cache,ld.so.preload,localtime,lsb-release,machine-id,mime.types,passwd,pulse,resolv.conf,ssl
#private-tmp

include /etc/firejail/default.profile
