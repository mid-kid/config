#Requires -RunAsAdministrator
$ErrorActionPreference = "Stop"

# Before anything, run these tools:
# - OOShutUp10
#   - Apply Recommended and somewhat recommended settings

# Post-install settings:
# - intl.cpl -> Administrative -> Copy settings...
# - sysdm.cpl -> Advanced -> Performance -> Advanced -> Virtual memory -> Set "No paging file"

# Finding new settings:
# Download Process Monitor (by sysinternals), filter by Operation=RegSetValue

function Reg { param ($Path, $Name, $Value, $PropertyType = 'DWord')
    if (!(Test-Path -Path $Path)) {
        New-Item -Path $Path -Force
    }
    New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $PropertyType -Force
}

function Disable-Service { param ($Name)
    Get-Service -Name $Name | Stop-Service -Force
    Get-Service -Name $Name | Set-Service -StartupType Disabled
}

# General: Disable Automatic Updates
## (gpedit) Computer Configuration -> Administrative Templates -> Windows Components -> Windows Update -> No auto-restart with logged on users for scheduled automatice updates installations = Enabled
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' NoAutoRebootWithLoggedOnUsers 1
# General: Enable developer mode (allow installing unsigned UWP apps without the store)
## (settings) Update & Security -> For Developers -> Developer Mode
Reg 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock' AllowDevelopmentWithoutDevLicense 1

# Shell: Set wallpaper
Reg 'HKCU:\Control Panel\Desktop' WallPaper "$pwd\img\Win10.jpg" -PropertyType String
# Shell: Set Lock Screen wallpaper
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization' LockScreenImage "$pwd\img\Win10HD.jpg" -PropertyType String

# Explorer: Avoid creating "System Volume Information" on USB drives
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows' DisableRemovableDriveIndexing 1

# Cleanup: Delete all system restore points and disable them
Disable-ComputerRestore -Drive $env:systemDrive
New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore' -Force | New-ItemProperty -Name DisableSR -Value 1 -Force
Get-Service -Name VSS | Set-Service -StartupType Manual
vssadmin Delete Shadows -All
Disable-Service VSS
# Cleanup: Disable reserved storage
Set-WindowsReservedStorageState -State Disabled
# Cleanup: Disable swapfile.sys
Reg 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' SwapfileControl 0
# Cleanup: Disable hibernation (frees up some disk space)
powercfg -h off
# Cleanup: Disable WinRE recovery
reagentc -disable
Remove-Item "${env:SystemDrive}\Recovery" -Recurse -Force -ErrorAction Ignore

# Refresh the environment
rundll32.exe user32.dll,UpdatePerUserSystemParameters
Stop-Process -Name explorer -Force
