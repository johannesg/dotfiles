# Install-Module posh-git -Scope CurrentUser
# Install-Module oh-my-posh -Scope CurrentUser
# Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck

Import-Module posh-git
Import-Module oh-my-posh
Import-Module PSReadLine

# Start the default settings
Set-Prompt
# Alternatively set the desired theme:
# Set-Theme Agnoster
Set-Theme Paradox

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

if (Test-Path "~\.jabba\jabba.ps1") { . "~\.jabba\jabba.ps1" }

$script:ScriptRoot = "~/.dotfiles/powershell"

. $script:ScriptRoot/functions.ps1

Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward