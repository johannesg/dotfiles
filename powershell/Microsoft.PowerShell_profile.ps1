# Load posh-git example profile

# . 'C:\Users\johannes\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1'
. "~\.dotfiles\powershell\prompt.ps1"


# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
