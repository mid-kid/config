#Requires -RunAsAdministrator

# C:\Windows\SysWOW64\OneDriveSetup.exe /uninstall

$uninstall = Get-Package -Name 'Microsoft OneDrive' -ProviderName Programs -ErrorAction Ignore | ForEach-Object -Process {$_.Meta.Attributes["UninstallString"]}
if ($uninstall) {
    echo 'Uninstalling OneDrive'
    Stop-Process -Name OneDrive -Force -ErrorAction Ignore
    iex "& $uninstall"
    pause
    Stop-Process -Name explorer -Force
    Remove-Item "$env:LocalAppData\Microsoft\OneDrive" -Force -Recurse
    Remove-Item "$env:ProgramData\Microsoft OneDrive" -Force -Recurse
}
