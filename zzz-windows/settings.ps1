#Requires -RunAsAdministrator
$ErrorActionPreference = "Stop"

# Before anything, run these tools:
# - OOShutUp10
#   - Apply Recommended and somewhat recommended settings

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

# General: Set wallpaper
Reg 'HKCU:\Control Panel\Desktop' WallPaper "$pwd\img\Win10.jpg" -PropertyType String
# General: Set Lock Screen wallpaper
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization' LockScreenImage "$pwd\img\Win10HD.jpg" -PropertyType String
# General: Disable background blur on Lock Screen
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' DisableAcrylicBackgroundOnLogon 1
# General: Use the normal touchpad scroll direction
## (settings) Devices -> Touchpad -> Scroll and zoom -> Scrolling direction = Down motion scrolls down
Reg 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PrecisionTouchPad' ScrollDirection 4294967295
# General: Set regional settings
## (settings) Time & Language -> Region -> Regional format = English (Europe)
Set-Culture en-150
## Short date = 2017-04-05
Reg 'HKCU:\Control Panel\International' sShortDate 'yyyy-MM-dd' -PropertyType String
Reg 'HKCU:\Control Panel\International' iDate '2' -PropertyType String
Reg 'HKCU:\Control Panel\International' sDate '-' -PropertyType String
# General: Set system clock to UTC (to match linux behavior)
Reg 'HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation' RealTimeIsUniversal 1
# General: Disable Automatic Updates
## (gpedit) Computer Configuration -> Administrative Templates -> Windows Components -> Windows Update -> Configure Automatic Updates = Disabled
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' NoAutoUpdate 1
# General: Enable developer mode (allow installing unsigned UWP apps without the store)
## (settings) Update & Security -> For Developers -> Developer Mode
Reg 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock' AllowDevelopmentWithoutDevLicense 1
# General: Disable windows search indexer
Disable-Service WSearch

# Cleanup: Delete all system restore points and disable them
Disable-ComputerRestore -Drive $env:systemDrive
New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore' -Force | New-ItemProperty -Name DisableSR -Value 1 -Force
Get-Service -Name VSS | Set-Service -StartupType Manual
vssadmin Delete Shadows -All
Disable-Service VSS
# Cleanup: Disable reserved storage
Set-WindowsReservedStorageState -State Disabled
# Cleanup: Disable swap file
Reg 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' SwapfileControl 0
# Cleanup: Disable hibernation (frees up some disk space)
powercfg -h off

# Privacy: Disable shared expriences
## (gpedit) Computer Configuration -> Administrative Templates -> System -> Group Policy -> Continue experiences on this device = Disabled
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' EnableCdp 0
# Privacy: Disable Xbox game bar
## (gpedit) Computer Configuration -> Administrative Templates -> Windows Components -> Windows Gmae Recording and Broadcasting -> Enables or disables Windows Game Recording and Broadcasting = Disabled
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR' AllowGameDVR 0
# Privacy: Disable Windows Defender
## (gpedit) Computer Configuration -> Administrative Templates -> Windows Components -> Microsoft Defender Antivirus -> Turn off Microsoft Defender Antivirus = Enabled
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' DisableAntiSpyware 1
## (gpedit) Computer Configuration -> Administrative Templates -> Windows Components -> Windows Defender SmartScreen -> Explorer -> Configure Windows Defender SmartScreen = Disaled
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' EnableSmartScreen 0
## (gpedit) Computer Configuration -> Administrative Templates -> Windows Components -> Windows Defender SmartScreen -> Microsoft Edge -> Configure Windows Defender SmartScreen = Disabled
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter' EnabledV9 0
## (settings) Windows Security -> App & browser control -> SmartScreen for Microsoft Store apps
Reg 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost' EnableWebContentEvaluation 0
Reg 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost' EnableWebContentEvaluation 0

# Shell: Disable revealing passwords
## (gpedit) Computer Configuration -> Administrative Templates -> Windows Components -> Credential User Interface -> Do not display the password reveal button = Enabled
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredUI' DisablePasswordReveal 1
# Shell: Don't use security questions for local accounts
## (gpedit) Computer Configuration -> Administrative Templates -> Windows Components -> Credential User Interface -> Prevent the use of security questions for local accounts = Enabled
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System\' NoLocalPasswordResetQuestions 1
# Shell: Disable restarting apps after reboot
Reg 'HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' RestartApps 0

# Explorer: Show file extensions
## (developer settings toggle)
Reg 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' HideFileExt 0
# Explorer: Show hidden and system files
## (developer settings toggle)
Reg 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' Hidden 1
# Explorer: Show full path in title bar
## (developer settings toggle)
Reg 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CabinetState' FullPath 1
# Explorer: Show Run as different user in Start
## (developer settings toggle)
Reg 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer' ShowRunAsDifferentUserInStart 1
# Explorer: Show empty drives
## (developer settings toggle)
Reg 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' HideDrivesWithNoMedia 0
# Explorer: Open to This PC instead of Quick Access
Reg 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' LaunchTo 1
# Explorer: Hide 3DObjects from "This PC"
Reg 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag' ThisPCPolicy Hide -PropertyType String
# Explorer: Show drive letter before drive name in My PC and location bar
Reg 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' ShowDriveLettersFirst 4
# Explorer: Disable Microsoft Store "Open With"
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' NoUseStoreOpenWith 1

# Taskbar: Make it small
Reg 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' TaskbarSmallIcons 1
# Taskbar: Don't combine buttons unless taskbar is full
#New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarGlomLevel -Value 1 -Force
# Taskbar: Always combine buttons
Reg 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' TaskbarGlomLevel 0
# Taskbar: Open the last active windows on click
Reg 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' LastActiveClick 1
# Taskbar: Show search icon instead of box
Reg 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' SearchboxTaskbarMode 1
# Taskbar: Show all icons in tray
Reg 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' EnableAutoTray 0
# Taskbar: Hide windows security from the systray
## (gpedit) Computer Configuration -> Administrative Templates -> Windows Components -> Windows Security -> Systray -> Hide Windows Security Systray = Enabled
Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray' HideSystray 1

# Refresh the environment
Stop-Process -Name explorer -Force

# NOTE: Managed by OOShutUp10
## Taskbar: Hide news and interests
#New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds' -Name ShellFeedsTaskbarViewMode -Value 2 -Force
## Privacy: Disable Delivery Optimization
## (settings) Update & Security
#New-ItemProperty -Path 'Registry::HKEY_USERS\S-1-5-20\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings' -Name DownloadMode -Value 0 -Force
#Delete-DeliveryOptimizationCache -Force
## Search: Don't store search history
#New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings' -Name IsDeviceSearchHistoryEnabled -Value 0 -Force
