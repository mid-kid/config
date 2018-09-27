noblacklist ~/.local/opt/arduino
whitelist ~/.local/opt/arduino

mkdir ~/.arduino15
noblacklist ~/.arduino15
whitelist ~/.arduino15

mkdir ~/.jssc
noblacklist ~/.jssc
whitelist ~/.jssc

noblacklist ~/Stuff/Workspace/Arduino
whitelist ~/Stuff/Workspace/Arduino

ignore noroot
include ~/.config/firejail/default.profile
