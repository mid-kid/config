# Sane set of exposed files for electron
private-bin bash,cut,echo,egrep,grep,head,sed,sh,tr,xdg-mime,xdg-open,zsh
private-etc alternatives,ca-certificates,crypto-policies,fonts,group,ld.so.cache,localtime,login.defs,machine-id,password,pki,resolv.conf,ssl

seccomp !chroot
ignore no3d
ignore net none
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/default.inc
