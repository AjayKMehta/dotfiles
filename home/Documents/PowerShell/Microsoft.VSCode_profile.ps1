Set-PoshPrompt -Theme "$env:LOCALAPPDATA\Programs\oh-my-posh\themes\bubblesextra.omp.json"

# https://github.com/SeeminglyScience/EditorServicesCommandSuite/issues/45#issuecomment-596243308
Import-Module EditorServicesCommandSuite

$scriptsFolder = Split-Path $PSScriptRoot -Parent | Join-Path -ChildPath scripts

# https://github.com/nightroman/Invoke-Build/wiki/Invoke-Task-from-VSCode
Register-EditorCommand -Name IB1 -DisplayName 'Invoke task' -ScriptBlock {
    . "$scriptsFolder\Invoke-TaskFromVSCode.ps1"
}

Register-EditorCommand -Name IB2 -DisplayName 'Invoke task in console' -SuppressOutput -ScriptBlock {
    . "$scriptsFolder\Invoke-TaskFromVSCode.ps1" -Console
}
