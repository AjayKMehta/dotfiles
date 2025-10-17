function Move-WslDistro {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateScript(
            { $_ -in $(wsl --list -q | Where-Object { $_.Trim() -ne '' }) },
            ErrorMessage = 'Please specify the name of a WSL distro.'
        )]
        [string] $Distro,
        [string] $TempFolder = 'D:/temp',
        [string] $Destination
    )
    $tarFile = Join-Path $TempFolder "$Distro.tar"
    wsl --export $Distro $tarFile
    wsl --unregister $Distro
    wsl --import $Distro $Destination $tarFile --version 2
}
