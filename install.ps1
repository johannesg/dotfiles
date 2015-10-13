
$DotFiles = $PSScriptRoot

& cmd.exe /c mklink $home\.vimrc $DotFiles\vimrc
& cmd.exe /c mklink /D $home\.vim $DotFiles\vim
& cmd.exe /c mklink /D $home\.agignore $DotFiles\agignore
