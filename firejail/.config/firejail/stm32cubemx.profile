whitelist ~/.firejail/stm32cubemx

mkdir ~/.stm32cubemx
whitelist ~/.stm32cubemx
mkdir ~/.stmcube
whitelist ~/.stmcube
mkdir ~/.stmcufinder
whitelist ~/.stmcufinder

ignore net none
include ~/.config/firejail/inc/java.inc
