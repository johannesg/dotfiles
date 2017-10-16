if ($host.Name -ne 'ConsoleHost')
{
    return
}

$script:ScriptRoot = "~/.dotfiles/powershell"

. $script:ScriptRoot/psreadline.ps1
. $script:ScriptRoot/functions.ps1

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
