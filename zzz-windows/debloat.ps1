#Requires -RunAsAdministrator

# Attempt at removing every single thing possible from the base windows installation.
# This operation should still allow for reinstalling the removed components at a later date.

$apps_exclude = @(
    # Required to install things...
    'Microsoft.WindowsStore'
)
$features_exclude = @(
)
$capabilities_exclude = @(
    # Cannot be removed
    'Language.Basic~*',
    'Language.TextToSpeech~*'
)

# Remove all apps
$apps_prov = Get-AppxProvisionedPackage -Online |
    where {$i=$_; -not ($apps_exclude | where {$i.DisplayName -like $_})}
$apps_prov | Format-Table
$apps_prov | Remove-AppxProvisionedPackage -Online
$apps = Get-AppxPackage |
    where {$i=$_; -not ($apps_exclude | where {$i.Name -like $_})}
$apps | Format-Table
$apps | Remove-AppxPackage -ErrorAction SilentlyContinue

# Remove all optional features
$features = Get-WindowsOptionalFeature -Online | where State -eq 'Enabled' |
    where {$i=$_; -not ($features_exclude | where {$i.FeatureName -like $_})}
$features | Format-Table
$features | Disable-WindowsOptionalFeature -Online -NoRestart

# Remove all optional capabilities
$capabilities = Get-WindowsCapability -Online | where State -eq 'Installed' |
    where {$i=$_; -not ($capabilities_exclude | where {$i.Name -like $_})}
$capabilities | Format-Table
$capabilities | Remove-WindowsCapability -Online

# Remove OneDrive
$uninstall = Get-Package -Name "Microsoft OneDrive" -ProviderName Programs -ErrorAction Ignore | ForEach-Object -Process {$_.Meta.Attributes["UninstallString"]}
if ($uninstall) {
    echo "Uninstalling OneDrive"
    taskkill /f /im OneDrive.exe
    iex "& $uninstall"
    pause
    Stop-Process -Name explorer -Force
    Remove-Item "$env:LocalAppData\Microsoft\OneDrive" -Force -Recurse
    Remove-Item "$env:ProgramData\Microsoft OneDrive" -Force -Recurse
}

# Remove Edge
# NOTE: It keeps reinstalling itself
#.\lib\uninstall_edge.ps1

# Unpin everything from the start menu
.\lib\unpin_start.ps1

# Reboot...
echo "Time to reboot"
pause
shutdown -r -t 0
