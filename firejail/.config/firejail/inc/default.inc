whitelist ~/.icons
whitelist ~/.themes
whitelist ~/.gtkrc-2.0
whitelist ~/.config/gtk-3.0/gtk.css
whitelist ~/.config/gtk-3.0/settings.ini
whitelist ~/.config/Trolltech.conf
whitelist ~/.config/qt5ct
read-only ~/.icons
read-only ~/.themes
read-only ~/.gtkrc-2.0
read-only ~/.config/gtk-3.0/gtk.css
read-only ~/.config/gtk-3.0/settings.ini
read-only ~/.config/Trolltech.conf
read-only ~/.config/qt5ct

caps.drop all
#ipc-namespace
#machine-id
net none
netfilter
no3d
nodvd
#nogroups
nonewprivs
noroot
nosound
notv
nou2f
novideo
protocol unix,inet,inet6
seccomp
#shell none

disable-mnt
private-dev
private-tmp

dbus-user none
dbus-system none

blacklist /boot
blacklist /etc/portage
blacklist /etc/gentoo-release
blacklist /etc/lsb-release
blacklist /etc/os-release
blacklist /etc/portage
blacklist /opt
blacklist /usr/local
blacklist /usr/portage
blacklist /usr/src
blacklist /usr/tmp

include disable-common.inc
include disable-devel.inc
include disable-interpreters.inc
include disable-passwdmgr.inc
include disable-programs.inc
include disable-write-mnt.inc
include disable-xdg.inc
