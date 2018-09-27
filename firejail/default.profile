# Theme things
whitelist ~/.icons
whitelist ~/.themes
whitelist ~/.gtkrc-2.0
whitelist ~/.config/gtk-3.0/gtk.css
whitelist ~/.config/gtk-3.0/settings.ini
whitelist ~/.config/Trolltech.conf
whitelist ~/.config/qt5ct

# Defaults
whitelist ~/.local/share/applications/mimeapps.list
whitelist ~/.local/share/applications/mimeinfo.cache
whitelist ~/.local/share/applications/defaults.list
read-only ~/.local/share/applications/mimeapps.list
read-only ~/.local/share/applications/mimeinfo.cache
read-only ~/.local/share/applications/defaults.list

include /etc/firejail/default.profile
