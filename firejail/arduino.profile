whitelist ~/.local/opt/arduino

noblacklist ~/.arduino15
mkdir ~/.arduino15
whitelist ~/.arduino15

noblacklist ~/.jssc
mkdir ~/.jssc
whitelist ~/.jssc

whitelist ~/Stuff/Workspace/Arduino

ignore noroot
include /etc/firejail/default.profile
