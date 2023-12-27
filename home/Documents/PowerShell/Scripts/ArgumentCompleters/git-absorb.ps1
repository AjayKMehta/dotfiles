
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'git-absorb' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'git-absorb'
        for ($i = 1; $i -lt $commandElements.Count; $i++) {
            $element = $commandElements[$i]
            if ($element -isnot [StringConstantExpressionAst] -or
                $element.StringConstantType -ne [StringConstantType]::BareWord -or
                $element.Value.StartsWith('-')) {
                break
        }
        $element.Value
    }) -join ';'

    $completions = @(switch ($command) {
        'git-absorb' {
            [CompletionResult]::new('-b', 'b', [CompletionResultType]::ParameterName, 'Use this commit as the base of the absorb stack')
            [CompletionResult]::new('--base', 'base', [CompletionResultType]::ParameterName, 'Use this commit as the base of the absorb stack')
            [CompletionResult]::new('--gen-completions', 'gen-completions', [CompletionResultType]::ParameterName, 'Generate completions')
            [CompletionResult]::new('-n', 'n', [CompletionResultType]::ParameterName, 'Don''t make any actual changes')
            [CompletionResult]::new('--dry-run', 'dry-run', [CompletionResultType]::ParameterName, 'Don''t make any actual changes')
            [CompletionResult]::new('-f', 'f', [CompletionResultType]::ParameterName, 'Skip safety checks')
            [CompletionResult]::new('--force', 'force', [CompletionResultType]::ParameterName, 'Skip safety checks')
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Display more output')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Display more output')
            [CompletionResult]::new('-r', 'r', [CompletionResultType]::ParameterName, 'Run rebase if successful')
            [CompletionResult]::new('--and-rebase', 'and-rebase', [CompletionResultType]::ParameterName, 'Run rebase if successful')
            [CompletionResult]::new('-w', 'w', [CompletionResultType]::ParameterName, 'Match the change against the complete file   ')
            [CompletionResult]::new('--whole-file', 'whole-file', [CompletionResultType]::ParameterName, 'Match the change against the complete file   ')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
