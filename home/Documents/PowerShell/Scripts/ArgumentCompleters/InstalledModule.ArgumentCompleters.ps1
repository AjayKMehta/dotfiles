#Requires -Modules Microsoft.PowerShell.PSResourceGet

using namespace System.Management.Automation
using namespace System.Management.Automation.Language

$script:sb = {
  param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

  Get-InstalledPSResource |
    Where-Object Type -EQ Module |
    Where-Object Name -Like "$wordToComplete*" |
    ForEach-Object {
      [CompletionResult]::new($_.Name, $_.Name, [CompletionResultType]::ParameterValue, $_.Description)
    }
}

Register-ArgumentCompleter -CommandName 'Get-InstalledModule', 'Update-Module', 'Uninstall-Module', 'Update-PSResource' -ParameterName Name -ScriptBlock $script:sb
