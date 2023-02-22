#Requires -RunAsAdministrator

# Clean up old packages
dism /online /cleanup-image /analyzecomponentstore
dism /online /cleanup-image /startcomponentcleanup /resetbase
dism /online /cleanup-image /analyzecomponentstore
# Offending dirs:
# - \Windows\WinSxS\Backup
# - \Windows\WinSxS\Temp

# Clean up windows update downloads
# NOTE: Not sure if these are useful at all
#Stop-Service wuauserv -Force
#Remove-Item "$env:systemDrive\Windows\SoftwareDistribution\Download" -Force -Recurse
#Start-Service wuauserv
#Remove-Item "$env:systemDrive\Windows\servicing\LCU" -Force -Recurse
