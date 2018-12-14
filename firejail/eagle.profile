noblacklist ~/.local/opt/eagle
whitelist ~/.local/opt/eagle

#mkfile ~/.~~~
#whitelist ~/.~~~
#mkfile ~/.eaglerc
#whitelist ~/.eaglerc

# Since the above barely works, you can patch the eagle binary to get this working:
# Version 9.0.0 eagle: 0x00b0c1c6 7263 => 2f5f 0x00b0c1c6
# Version 9.1.3 eagle: 0x00c0a494 7263 => 2f5f 0x00c0a494
# Version 9.2.0 eagle: 0x00cc3c54 7263 => 2f5f 0x00cc3c54
mkdir ~/.eagle
noblacklist ~/.eagle
whitelist ~/.eagle
mkdir ~/.config/Autodesk
noblacklist ~/.config/Autodesk
whitelist ~/.config/Autodesk
mkdir ~/.local/share/Eagle
noblacklist ~/.local/share/Eagle
whitelist ~/.local/share/Eagle

noblacklist ~/Stuff/Workspace/Eagle
whitelist ~/Stuff/Workspace/Eagle

protocol unix,inet,inet6,netlink
include ~/.config/firejail/default.profile
