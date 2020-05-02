whitelist ~/.firejail/discord

mkdir ~/.config/discord
noblacklist ~/.config/discord
whitelist ~/.config/discord

# discord-ipc...
whitelist ${RUNUSER}/discord-ipc-0

# betterdiscord
mkdir ~/.local/share/betterdiscordctl
whitelist ~/.local/share/betterdiscordctl
mkdir ~/.config/BetterDiscord
whitelist ~/.config/BetterDiscord

private-bin bash,cut,echo,egrep,grep,head,sed,sh,tr,xdg-mime,xdg-open,zsh
private-etc alternatives,ca-certificates,crypto-policies,fonts,group,ld.so.cache,localtime,login.defs,machine-id,password,pki,resolv.conf,ssl

ignore nodbus
ignore novideo
include ~/.config/firejail/inc/electron.inc
