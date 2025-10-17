function Set-FzfTheme {
    [CmdletBinding()]
    param (
        [ArgumentCompleter({
                param (
                    $CommandName,
                    $ParameterName,
                    $WordToComplete,
                    $CommandAst,
                    $FakeBoundParameters
                )
                Get-ChildItem "$Env:XDG_CONFIG_HOME/fzf/themes" -Filter "$WordToComplete*.fzf-theme.json" |
                    ForEach-Object {
                        $file = "'$($_.FullName)'"
                        # 15 = ".fzf-theme.json".Length
                        $name = $_.Name.Substring(0, $_.Name.Length - 15)
                        [System.Management.Automation.CompletionResult]::new($file, $name, 'ParameterValue', $name)
                    } | Sort-Object -Property ListItemText
            })]
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $ThemePath
    )

    $theme = Get-Content -Path $ThemePath -Encoding UTF8 | ConvertFrom-Json -AsHashtable

    if ($null -eq $theme) {
        throw "Theme not found in $ThemePath"
    }

    if (-not $theme.colors -or $theme.colors.Count -eq 0) {
        throw 'Theme must contain colors!'
    }

    $colorString = $theme.colors.GetEnumerator().ForEach({ "$($_.Key):$($_.Value)" }) -join ','
    $colorString = "--color='$colorString'"

    # Get current FZF_DEFAULT_OPS
    [string] $fzfOpts = $env:FZF_DEFAULT_OPTS

    if ($fzfOpts) {
        # Remove existing --color options if they exist
        $fzfOpts = $fzfOpts -replace "--color[=\s]('[^']+'|\S+)", ''
        $fzfOpts += " $colorString"
    } else {
        $fzfOpts = $colorString
    }
    Write-Verbose "Switching to theme $($theme.name)"
    $env:FZF_DEFAULT_OPTS = $fzfOpts
}
