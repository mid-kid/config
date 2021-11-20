#Requires -RunAsAdministrator

# Fix the few settings that are reset with every windows update...

# Remove Edge
.\lib\uninstall_edge.ps1

# Clean up old packages
dism /online /cleanup-image /analyzecomponentstore
dism /online /cleanup-image /startcomponentcleanup /resetbase
# Offending dirs:
# - \Windows\WinSxS\Backup
# - \Windows\WinSxS\Temp

# Clean up windows update downloads
# NOTE: Not sure if these are useful at all
#Stop-Service wuauserv -Force
#Remove-Item "$env:systemDrive\Windows\SoftwareDistribution\Download" -Force -Recurse
#Start-Service wuauserv
#Remove-Item "$env:systemDrive\Windows\servicing\LCU" -Force -Recurse
