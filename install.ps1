
$DotFiles = $PSScriptRoot

mkdir .config

# & cmd.exe /c mklink $home\.vimrc $DotFiles\vimrc
# & cmd.exe /c mklink /D $home\.vim $DotFiles\vim
# & cmd.exe /c mklink /D $home\vimfiles $DotFiles\vim
# & cmd.exe /c mklink /D $home\.agignore $DotFiles\agignore
# & cmd.exe /c mklink /D $home\.emacs.d $DotFiles\emacs.d
# & cmd.exe /c mklink $home\.gitconfig $DotFiles\gitconfig
# & cmd.exe /c mklink $home\.gitignore_global $DotFiles\gitignore_global
& cmd.exe /c mklink /D $home\AppData\Local\nvim $DotFiles\nvim\.config\nvim
& cmd.exe /c mklink /D $home\.config\wezterm $DotFiles\wezterm\.config\wezterm
& cmd.exe /c mklink $home\.config\starship.toml $DotFiles\starship\.config\starship.toml

# if (!(Test-Path $home\.lein)) { mkdir $home\.lein }
# if (!(Test-Path $home\Documents\WindowsPowerShell)) { mkdir $home\Documents\WindowsPowerShell }
# if (!(Test-Path $home\Documents\PowerShell)) { mkdir $home\Documents\PowerShell }


# & cmd.exe /c mklink $home\.lein\profiles.clj $DotFiles\lein\profiles.clj

# & cmd.exe /c mklink $home\Documents\WindowsPowerShell\Profile.ps1 $DotFiles\powershell\Profile.ps1
# & cmd.exe /c mklink $home\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 $DotFiles\powershell\Microsoft.PowerShell_profile.ps1
# & cmd.exe /c mklink $home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 $DotFiles\powershell\Microsoft.PowerShell_profile.ps1
# & cmd.exe /c mklink $home\Documents\PowerShell\profile.ps1 $DotFiles\powershell\profile.ps1

# cp $DotFiles\powershell\Profile.ps1 $home\Documents\PowerShell\
# cp $DotFiles\powershell\Microsoft.PowerShell_profile.ps1 $home\Documents\PowerShell\


# & cmd.exe /c mklink $home\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json $DotFiles\WindowsTerminal\profiles.json
