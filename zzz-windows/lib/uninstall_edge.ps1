#Requires -RunAsAdministrator

$uninstall = Get-Package -Name "Microsoft Edge" -ProviderName Programs -ErrorAction Ignore | ForEach-Object -Process {$_.Meta.Attributes["UninstallString"]}
if ($uninstall) {
	echo "Uninstalling Edge"
	iex "& $uninstall"
	pause
	Remove-Item "${env:ProgramFiles(x86)}\Microsoft\Edge" -Force -Recurse
}