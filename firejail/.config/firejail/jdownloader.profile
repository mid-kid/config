noblacklist ~/.local/opt/jd2
whitelist ~/.local/opt/jd2

noblacklist ${DOWNLOADS}
whitelist ${DOWNLOADS}

protocol unix,inet,inet6,netlink
include ~/.config/firejail/default.profile
