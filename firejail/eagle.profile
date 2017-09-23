noblacklist ~/.local/opt/eagle
whitelist ~/.local/opt/eagle

#mkfile ~/.~~~
#noblacklist ~/.~~~
#whitelist ~/.~~~
#mkfile ~/.eaglerc
#noblacklist ~/.eaglerc
#whitelist ~/.eaglerc

# Since the above barely works, you can patch the eagle binary to get this working:
# Version 7.7.0 bin/eagle
# 0x01186986 7263 => 2f5f 0x01186986
mkdir ~/.eagle
mkfile ~/.eagle/_
noblacklist ~/.eagle
whitelist ~/.eagle

noblacklist ~/Stuff/Workspace/Eagle
whitelist ~/Stuff/Workspace/Eagle

include /etc/firejail/default.profile
