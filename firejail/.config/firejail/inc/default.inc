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

whitelist ~/.asoundrc
read-only ~/.asoundrc

whitelist ~/.config/mimeapps.list
read-only ~/.config/mimeapps.list
whitelist ~/.local/share/applications/
read-only ~/.local/share/applications/

caps.drop all
#ipc-namespace
netfilter
no3d
nodbus
nodvd
#nogroups
nonewprivs
noroot
#nosound
notv
novideo
protocol unix,inet,inet6
seccomp
#shell none
net none
#memory-deny-write-execute

disable-mnt
private-tmp
private-dev

whitelist ${RUNUSER}/pulse
read-only ${RUNUSER}/pulse
read-only /tmp/.X11-unix
blacklist /boot
blacklist /opt
blacklist /usr/src
blacklist /usr/tmp
blacklist /usr/portage
blacklist /usr/local
blacklist /etc/os-release
whitelist /var/tmp
whitelist /var/run

include /etc/firejail/disable-common.inc
include /etc/firejail/disable-devel.inc
include /etc/firejail/disable-interpreters.inc
include /etc/firejail/disable-passwdmgr.inc
include /etc/firejail/disable-programs.inc
include /etc/firejail/disable-xdg.inc
