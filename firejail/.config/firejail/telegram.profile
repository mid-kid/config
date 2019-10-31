whitelist ~/.firejail/telegram

mkdir ~/.local/share/TelegramDesktop
noblacklist ~/.local/share/TelegramDesktop
whitelist ~/.local/share/TelegramDesktop

# Telegram takes very long to generate a cache for this with noto-cjk installed, so it's best to keep it around...
mkdir ~/.cache/fontconfig_11
whitelist ~/.cache/fontconfig_11

ignore nodbus
ignore net none
include ~/.config/firejail/inc/default.inc
