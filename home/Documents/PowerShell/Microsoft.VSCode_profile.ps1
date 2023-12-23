Set-PoshPrompt -Theme powerlevel10k_lean

Import-Module EditorServicesCommandSuite
Import-CommandSuite

# https://github.com/nightroman/Invoke-Build/wiki/Invoke-Task-from-VSCode
Register-EditorCommand -Name IB1 -DisplayName 'Invoke task' -ScriptBlock {
    Invoke-TaskFromVSCode.ps1
}

Register-EditorCommand -Name IB2 -DisplayName 'Invoke task in console' -SuppressOutput -ScriptBlock {
    Invoke-TaskFromVSCode.ps1 -Console
}
