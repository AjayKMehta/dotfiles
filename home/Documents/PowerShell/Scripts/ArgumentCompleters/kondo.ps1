
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'kondo' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'kondo'
        for ($i = 1; $i -lt $commandElements.Count; $i++) {
            $element = $commandElements[$i]
            if ($element -isnot [StringConstantExpressionAst] -or
                $element.StringConstantType -ne [StringConstantType]::BareWord -or
                $element.Value.StartsWith('-') -or
                $element.Value -eq $wordToComplete) {
                break
        }
        $element.Value
    }) -join ';'

    $completions = @(switch ($command) {
        'kondo' {
            [CompletionResult]::new('-I', 'I ', [CompletionResultType]::ParameterName, 'Directories to ignore. Will also prevent recursive traversal within')
            [CompletionResult]::new('--ignored-dirs', 'ignored-dirs', [CompletionResultType]::ParameterName, 'Directories to ignore. Will also prevent recursive traversal within')
            [CompletionResult]::new('-o', 'o', [CompletionResultType]::ParameterName, 'Only directories with a file last modified n units of time ago will be looked at. Ex: 20d. Units are m: minutes, h: hours, d: days, w: weeks, M: months and y: years')
            [CompletionResult]::new('--older', 'older', [CompletionResultType]::ParameterName, 'Only directories with a file last modified n units of time ago will be looked at. Ex: 20d. Units are m: minutes, h: hours, d: days, w: weeks, M: months and y: years')
            [CompletionResult]::new('--completions', 'completions', [CompletionResultType]::ParameterName, 'Generates completions for the specified shell')
            [CompletionResult]::new('-q', 'q', [CompletionResultType]::ParameterName, 'Quiet mode. Won''t output to the terminal. -qq prevents all output')
            [CompletionResult]::new('--quiet', 'quiet', [CompletionResultType]::ParameterName, 'Quiet mode. Won''t output to the terminal. -qq prevents all output')
            [CompletionResult]::new('-a', 'a', [CompletionResultType]::ParameterName, 'Clean all found projects without confirmation')
            [CompletionResult]::new('--all', 'all', [CompletionResultType]::ParameterName, 'Clean all found projects without confirmation')
            [CompletionResult]::new('-L', 'L ', [CompletionResultType]::ParameterName, 'Follow symbolic links')
            [CompletionResult]::new('--follow-symlinks', 'follow-symlinks', [CompletionResultType]::ParameterName, 'Follow symbolic links')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Restrict directory traversal to the root filesystem')
            [CompletionResult]::new('--same-filesystem', 'same-filesystem', [CompletionResultType]::ParameterName, 'Restrict directory traversal to the root filesystem')
            [CompletionResult]::new('-d', 'd', [CompletionResultType]::ParameterName, 'If there is no input, defaults to yes')
            [CompletionResult]::new('--default', 'default', [CompletionResultType]::ParameterName, 'If there is no input, defaults to yes')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
