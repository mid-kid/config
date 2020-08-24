whitelist ~/.local/share/firejail/telegram

mkdir ~/.local/share/TelegramDesktop
noblacklist ~/.local/share/TelegramDesktop
whitelist ~/.local/share/TelegramDesktop

ignore nodbus
ignore net none
include ~/.config/firejail/inc/default.inc
