function Setup-Environment {
  Install-Module posh-git -Scope CurrentUser
  Install-Module oh-my-posh -Scope CurrentUser
  Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
}

function Start-ExplorerHere
{
  Start-Process -FilePath "$env:SystemRoot\explorer.exe" -ArgumentList "$pwd" | Out-Null
}

#####
# http://www.peterprovost.org/archive/2006/08/02/17838.aspx

if( $GLOBAL:go_locations -eq $null ) {
    $GLOBAL:go_locations = @{}
}

function Goto-Location( [string] $location ) {
    if( $go_locations.ContainsKey($location) ) {
        set-location $go_locations[$location]
    } else {
        write-output "The following locations are defined:"
        write-output $go_locations
    }
}

$go_locations.Clear()
$go_locations.Add("home", "~")
$go_locations.Add("pf", "$env:ProgramFiles")
$go_locations.Add("appdata", "$env:ProgramData")
$go_locations.Add("jpj", "C:\Dev\jpj")

function wp
{
  & "C:\Program Files\Windows NT\Accessories\wordpad.exe" $args
}

function Open-Editor
{
  param([parameter(valuefrompipeline=$true)]$files)

  PROCESS {
    if (!(Test-Path $files)) {
      & "C:\Program Files (x86)\Notepad++\notepad++.exe" $files
    }
    else {  
      gi $files | % {
        if (!$_.PSIsContainer) {
          & "C:\Program Files (x86)\Notepad++\notepad++.exe" $_ 
        }
      }
    }
  }
}

function em {
  param([parameter(valuefrompipeline=$true)]$files)

  PROCESS {
    if (!(Test-Path $files)) {
      & emacsclient -na runemacs $files
    }
    else {  
      gi $files | % {
        if (!$_.PSIsContainer) {
          & emacsclient -na runemacs $_ 
        }
      }
    }
  }
}

function purge-dir
{
  param($dir)
  $tempDir = "$($env:TEMP)\__empty__"
  mkdir -fo $tempDir | out-null
  rm $tempDir\* -rec -fo | out-null
  robocopy /purge $tempDir $dir
}

# function paket
# {
#     if (Test-Path ".paket\paket.exe") {
#         .paket\paket.exe $args
#     } else {
#         Write-Host "paket not found"
#     }
# }

#function fake
#{
#    if (Test-Path "packages\FAKE\tools\FAKE.exe") {
#        packages\FAKE\tools\FAKE.exe $args
#    } else {
#        Write-Host "fake not found"
#    }
#}

function msbuild {
	$path = vswhere -latest -products * -requires Microsoft.Component.MSBuild -property installationPath
	if ($path) {
	  $path = join-path $path 'MSBuild\15.0\Bin\MSBuild.exe'
	  if (test-path $path) {
		& $path $args
	  }
	}
}

Set-Alias eh Start-ExplorerHere
Set-Alias e Open-Editor
Set-Alias g Goto-Location
Set-Alias Get-Random Microsoft.PowerShell.Utility\Get-Random
