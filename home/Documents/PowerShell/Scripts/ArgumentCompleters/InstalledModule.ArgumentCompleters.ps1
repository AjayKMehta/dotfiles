using namespace System.Management.Automation
using namespace System.Management.Automation.Language

$script:modules

$script:sb = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

  if (!$script:modules) {
    $script:modules = Get-InstalledModule
	}

    $modules | Where-Object Name -like "$wordToComplete*" |
    ForEach-Object {
		[CompletionResult]::new($_.Name, $_.Name, [CompletionResultType]::ParameterValue, $_.Description)
    }
}

Register-ArgumentCompleter -CommandName 'Get-InstalledModule', 'Update-Module', 'Uninstall-Module', 'Update-PSResource' -ParameterName Name -ScriptBlock $script:sb
