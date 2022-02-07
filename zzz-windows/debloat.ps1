#Requires -RunAsAdministrator

# Attempt at removing every single thing possible from the base windows installation.
# This operation should still allow for reinstalling the removed components at a later date.

$apps_exclude = @(
    # Required to install things...
    'Microsoft.WindowsStore'
)
$capabilities_exclude = @(
    # Cannot be removed
    'Language.Basic~*',

    # Stuff I generally want to keep
    'Microsoft.Windows.MSPaint~*',
    'Microsoft.Windows.Notepad~*'
)
$features_exclude = @(
)

# Remove all apps
$apps = Get-AppxPackage |
    where {$i=$_; -not ($apps_exclude | where {$i.Name -like $_})}
$apps | Format-Table
$prompt = Read-Host -Prompt 'Remove apps? (n)'
if ($prompt -eq 'y') {
    $apps | Remove-AppxPackage -ErrorAction SilentlyContinue
}

# Remove all provisioned apps
$apps_prov = Get-AppxProvisionedPackage -Online |
    where {$i=$_; -not ($apps_exclude | where {$i.DisplayName -like $_})}
$apps_prov | Format-Table
$prompt = Read-Host -Prompt 'Remove provisioned apps? (n)'
if ($prompt -eq 'y') {
    $apps_prov | Remove-AppxProvisionedPackage -Online
}

# Remove all capabilities
$capabilities = Get-WindowsCapability -Online | where State -eq 'Installed' |
    where {$i=$_; -not ($capabilities_exclude | where {$i.Name -like $_})}
$capabilities | Format-Table
$prompt = Read-Host -Prompt 'Remove capabilities? (n)'
if ($prompt -eq 'y') {
    $capabilities | Remove-WindowsCapability -Online
}

# Remove all optional features
$features = Get-WindowsOptionalFeature -Online | where State -eq 'Enabled' |
    where {$i=$_; -not ($features_exclude | where {$i.FeatureName -like $_})}
$features | Format-Table
$prompt = Read-Host -Prompt 'Disable optional features? (n)'
if ($prompt -eq 'y') {
    $features | Disable-WindowsOptionalFeature -Online -NoRestart
}

# Remove bloatware
$prompt = Read-Host -Prompt 'Uninstall OneDrive? (n)'
if ($prompt -eq 'y') {
    .\lib\uninstall_onedrive.ps1
}
$prompt = Read-Host -Prompt 'Uninstall Edge? (n)'
if ($prompt -eq 'y') {
    .\lib\uninstall_edge.ps1
}

# Unpin everything from the start menu
$prompt = Read-Host -Prompt 'Unpin all applications? (n)'
if ($prompt -eq 'y') {
    .\lib\unpin_start.ps1
}

# Reboot...
echo "Time to reboot"
pause
shutdown -r -t 0
