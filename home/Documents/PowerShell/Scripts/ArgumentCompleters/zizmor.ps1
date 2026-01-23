
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'zizmor' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'zizmor'
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
        'zizmor' {
            [CompletionResult]::new('--persona', '--persona', [CompletionResultType]::ParameterName, 'The persona to use while auditing')
            [CompletionResult]::new('--gh-token', '--gh-token', [CompletionResultType]::ParameterName, 'The GitHub API token to use')
            [CompletionResult]::new('--gh-hostname', '--gh-hostname', [CompletionResultType]::ParameterName, 'The GitHub Server Hostname. Defaults to github.com')
            [CompletionResult]::new('--format', '--format', [CompletionResultType]::ParameterName, 'The output format to emit. By default, cargo-style diagnostics will be emitted')
            [CompletionResult]::new('--render-links', '--render-links', [CompletionResultType]::ParameterName, 'Whether to render OSC 8 links in the output')
            [CompletionResult]::new('--show-audit-urls', '--show-audit-urls', [CompletionResultType]::ParameterName, 'Whether to render audit URLs in the output, separately from any URLs embedded in OSC 8 links')
            [CompletionResult]::new('--color', '--color', [CompletionResultType]::ParameterName, 'Control the use of color in output')
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'The configuration file to load. This loads a single configuration file across all input groups, which may not be what you intend')
            [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'The configuration file to load. This loads a single configuration file across all input groups, which may not be what you intend')
            [CompletionResult]::new('--min-severity', '--min-severity', [CompletionResultType]::ParameterName, 'Filter all results below this severity')
            [CompletionResult]::new('--min-confidence', '--min-confidence', [CompletionResultType]::ParameterName, 'Filter all results below this confidence')
            [CompletionResult]::new('--cache-dir', '--cache-dir', [CompletionResultType]::ParameterName, 'The directory to use for HTTP caching. By default, a host-appropriate user-caching directory will be used')
            [CompletionResult]::new('--collect', '--collect', [CompletionResultType]::ParameterName, 'Control which kinds of inputs are collected for auditing')
            [CompletionResult]::new('--completions', '--completions', [CompletionResultType]::ParameterName, 'Generate tab completion scripts for the specified shell')
            [CompletionResult]::new('--fix', '--fix', [CompletionResultType]::ParameterName, 'Fix findings automatically, when available (EXPERIMENTAL)')
            [CompletionResult]::new('--lsp', '--lsp', [CompletionResultType]::ParameterName, 'Run in language server mode (EXPERIMENTAL)')
            [CompletionResult]::new('--stdio', '--stdio', [CompletionResultType]::ParameterName, 'stdio')
            [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'Emit ''pedantic'' findings')
            [CompletionResult]::new('--pedantic', '--pedantic', [CompletionResultType]::ParameterName, 'Emit ''pedantic'' findings')
            [CompletionResult]::new('-o', '-o', [CompletionResultType]::ParameterName, 'Perform only offline operations')
            [CompletionResult]::new('--offline', '--offline', [CompletionResultType]::ParameterName, 'Perform only offline operations')
            [CompletionResult]::new('--no-online-audits', '--no-online-audits', [CompletionResultType]::ParameterName, 'Perform only offline audits')
            [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
            [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
            [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
            [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
            [CompletionResult]::new('--no-progress', '--no-progress', [CompletionResultType]::ParameterName, 'Don''t show progress bars, even if the terminal supports them')
            [CompletionResult]::new('--no-config', '--no-config', [CompletionResultType]::ParameterName, 'Disable all configuration loading')
            [CompletionResult]::new('--no-exit-codes', '--no-exit-codes', [CompletionResultType]::ParameterName, 'Disable all error codes besides success and tool failure')
            [CompletionResult]::new('--strict-collection', '--strict-collection', [CompletionResultType]::ParameterName, 'Fail instead of warning on syntax and schema errors in collected inputs')
            [CompletionResult]::new('--naches', '--naches', [CompletionResultType]::ParameterName, 'Enable naches mode')
            [CompletionResult]::new('--thanks', '--thanks', [CompletionResultType]::ParameterName, 'Emit thank-you messages for zizmor''s sponsors')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('-V', '-V ', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('--version', '--version', [CompletionResultType]::ParameterName, 'Print version')
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
