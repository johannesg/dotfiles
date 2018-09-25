function Start-ExplorerHere
{
  Start-Process -FilePath "$env:SystemRoot\explorer.exe" -ArgumentList "$pwd" | Out-Null
}

Function Stop-Host
{
   if ($nestedpromptlevel -ge 1)
   {
       $Host.ExitNestedPrompt()
   }
   else
   {
       $Host.SetShouldExit($True)
   }
}

Function New-NestedHost
{
   $Host.EnterNestedPrompt()
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
$go_locations.Add("tr", "E:\Dev\inexchange\svn\trunk")
$go_locations.Add("t", "E:\Dev\inexchange\svn\branches\test")
$go_locations.Add("d", "E:\Dev\inexchange\svn\branches\working")
$go_locations.Add("m", "E:\Dev\inexchange\svn\merge")
$go_locations.Add("pf", "$env:ProgramFiles")
$go_locations.Add("unsent", "$env:ProgramData\InExchange Factorum\VirtualPrinter\$env:COMPUTERNAME\$env:USERNAME\Unsent")
$go_locations.Add("appdata", "$env:ProgramData")
$go_locations.Add("nh", "E:\dev\Source\NHibernate\trunk\nhibernate\src")
$go_locations.Add("dep", "E:\Dev\inexchange\svn\trunk\deployment\Configurations")

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

function gvimr
{
   & "C:\Program Files (x86)\Vim\vim74\gvim.exe" --remote-tab $args
}

function purge-dir
{
  param($dir)
  $tempDir = "$($env:TEMP)\__empty__"
  mkdir -fo $tempDir | out-null
  rm $tempDir\* -rec -fo | out-null
  robocopy /purge $tempDir $dir
}

function paket
{
    if (Test-Path ".paket\paket.exe") {
        .paket\paket.exe $args
    } else {
        Write-Host "paket not found"
    }
}

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
Set-Alias x Stop-Host
Set-Alias nest New-NestedHost
Set-Alias e Open-Editor
Set-Alias g Goto-Location
Set-Alias Get-Random Microsoft.PowerShell.Utility\Get-Random
