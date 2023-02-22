#Requires -RunAsAdministrator

function Disable-Service { param ($Name)
    Get-Service -Name $Name | Stop-Service -Force
    Get-Service -Name $Name | Set-Service -StartupType Disable
}

# Performance: Disable Windows Search (continuous indexer)
Disable-Service WSearch

# Cleanup: Disable pagefile.sys
$w = Gwmi Win32_ComputerSystem
$w.AutomaticManagedPagefile = $False
$w.Put()
$w = Gwmi Win32_PageFileSetting
foreach ($x in $w) { $x.Delete() }