
$DotFiles = $PSScriptRoot

& cmd.exe /c mklink $home\.vimrc $DotFiles\vimrc
& cmd.exe /c mklink /D $home\.vim $DotFiles\vim
& cmd.exe /c mklink /D $home\.agignore $DotFiles\agignore
& cmd.exe /c mklink /D $home\.emacs.d $DotFiles\emacs.d

& cmd.exe /c mklink $home\Documents\WindowsPowershell\Profile.ps1 $DotFiles\powershell\Profile.ps1
& cmd.exe /c mklink $home\Documents\WindowsPowershell\Microsoft.PowerShell_profile.ps1 $DotFiles\powershell\Microsoft.PowerShell_profile.ps1
