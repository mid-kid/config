# TODO: What syscalls need to be enabled?
ignore seccomp
ignore no3d
ignore net none
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/default.inc
