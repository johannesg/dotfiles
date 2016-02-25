#Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Load posh-git module from current directory
# Import-Module .\posh-git

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
# Import-Module posh-git

$gitloaded = $false

function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE
    # Output prompt string

    $sepChar = ''
    if ($Pscx:IsAdmin -eq $true) {
        $sepChar = '#'
	  }

    Write-Host "[$($pwd.ProviderPath)]" -nonewline
    if (Test-Path ("$(pwd)/.git")) {
        if (!$gitloaded) { Import-Module posh-git }
        Write-VcsStatus
    }
    Write-Host ""

    $global:LASTEXITCODE = $realLASTEXITCODE

    return "PS" + $sepChar + '>' + '>' * $nestedpromptlevel
}
