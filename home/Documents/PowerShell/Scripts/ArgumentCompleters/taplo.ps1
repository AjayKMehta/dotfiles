
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'taplo' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'taplo'
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
        'taplo' {
            [CompletionResult]::new('--colors', 'colors', [CompletionResultType]::ParameterName, 'colors')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable a verbose logging format')
            [CompletionResult]::new('--log-spans', 'log-spans', [CompletionResultType]::ParameterName, 'Enable logging spans')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('-V', 'V ', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('lint', 'lint', [CompletionResultType]::ParameterValue, 'Lint TOML documents')
            [CompletionResult]::new('format', 'format', [CompletionResultType]::ParameterValue, 'Format TOML documents')
            [CompletionResult]::new('lsp', 'lsp', [CompletionResultType]::ParameterValue, 'Language server operations')
            [CompletionResult]::new('config', 'config', [CompletionResultType]::ParameterValue, 'Operations with the Taplo config file')
            [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Extract a value from the given TOML document')
            [CompletionResult]::new('toml-test', 'toml-test', [CompletionResultType]::ParameterValue, 'Start a decoder for `toml-test` (https://github.com/BurntSushi/toml-test)')
            [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate completions for Taplo CLI')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'taplo;lint' {
            [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Path to the Taplo configuration file')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Path to the Taplo configuration file')
            [CompletionResult]::new('--cache-path', 'cache-path', [CompletionResultType]::ParameterName, 'Set a cache path')
            [CompletionResult]::new('--schema', 'schema', [CompletionResultType]::ParameterName, 'URL to the schema to be used for validation')
            [CompletionResult]::new('--schema-catalog', 'schema-catalog', [CompletionResultType]::ParameterName, 'URL to a schema catalog (index) that is compatible with Schema Store or Taplo catalogs')
            [CompletionResult]::new('--colors', 'colors', [CompletionResultType]::ParameterName, 'colors')
            [CompletionResult]::new('--no-auto-config', 'no-auto-config', [CompletionResultType]::ParameterName, 'Do not search for a configuration file')
            [CompletionResult]::new('--default-schema-catalogs', 'default-schema-catalogs', [CompletionResultType]::ParameterName, 'Use the default online catalogs for schemas')
            [CompletionResult]::new('--no-schema', 'no-schema', [CompletionResultType]::ParameterName, 'Disable all schema validations')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable a verbose logging format')
            [CompletionResult]::new('--log-spans', 'log-spans', [CompletionResultType]::ParameterName, 'Enable logging spans')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'taplo;format' {
            [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Path to the Taplo configuration file')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Path to the Taplo configuration file')
            [CompletionResult]::new('--cache-path', 'cache-path', [CompletionResultType]::ParameterName, 'Set a cache path')
            [CompletionResult]::new('-o', 'o', [CompletionResultType]::ParameterName, 'A formatter option given as a "key=value", can be set multiple times')
            [CompletionResult]::new('--option', 'option', [CompletionResultType]::ParameterName, 'A formatter option given as a "key=value", can be set multiple times')
            [CompletionResult]::new('--stdin-filepath', 'stdin-filepath', [CompletionResultType]::ParameterName, 'A path to the file that the Taplo CLI will treat like stdin')
            [CompletionResult]::new('--colors', 'colors', [CompletionResultType]::ParameterName, 'colors')
            [CompletionResult]::new('--no-auto-config', 'no-auto-config', [CompletionResultType]::ParameterName, 'Do not search for a configuration file')
            [CompletionResult]::new('-f', 'f', [CompletionResultType]::ParameterName, 'Ignore syntax errors and force formatting')
            [CompletionResult]::new('--force', 'force', [CompletionResultType]::ParameterName, 'Ignore syntax errors and force formatting')
            [CompletionResult]::new('--check', 'check', [CompletionResultType]::ParameterName, 'Dry-run and report any files that are not correctly formatted')
            [CompletionResult]::new('--diff', 'diff', [CompletionResultType]::ParameterName, 'Print the differences in patch formatting to `stdout`')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable a verbose logging format')
            [CompletionResult]::new('--log-spans', 'log-spans', [CompletionResultType]::ParameterName, 'Enable logging spans')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'taplo;lsp' {
            [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Path to the Taplo configuration file')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Path to the Taplo configuration file')
            [CompletionResult]::new('--cache-path', 'cache-path', [CompletionResultType]::ParameterName, 'Set a cache path')
            [CompletionResult]::new('--colors', 'colors', [CompletionResultType]::ParameterName, 'colors')
            [CompletionResult]::new('--no-auto-config', 'no-auto-config', [CompletionResultType]::ParameterName, 'Do not search for a configuration file')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable a verbose logging format')
            [CompletionResult]::new('--log-spans', 'log-spans', [CompletionResultType]::ParameterName, 'Enable logging spans')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('tcp', 'tcp', [CompletionResultType]::ParameterValue, 'Run the language server and listen on a TCP address')
            [CompletionResult]::new('stdio', 'stdio', [CompletionResultType]::ParameterValue, 'Run the language server over the standard input and output')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'taplo;lsp;tcp' {
            [CompletionResult]::new('--address', 'address', [CompletionResultType]::ParameterName, 'The address to listen on')
            [CompletionResult]::new('--colors', 'colors', [CompletionResultType]::ParameterName, 'colors')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable a verbose logging format')
            [CompletionResult]::new('--log-spans', 'log-spans', [CompletionResultType]::ParameterName, 'Enable logging spans')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'taplo;lsp;stdio' {
            [CompletionResult]::new('--colors', 'colors', [CompletionResultType]::ParameterName, 'colors')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable a verbose logging format')
            [CompletionResult]::new('--log-spans', 'log-spans', [CompletionResultType]::ParameterName, 'Enable logging spans')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'taplo;lsp;help' {
            [CompletionResult]::new('tcp', 'tcp', [CompletionResultType]::ParameterValue, 'Run the language server and listen on a TCP address')
            [CompletionResult]::new('stdio', 'stdio', [CompletionResultType]::ParameterValue, 'Run the language server over the standard input and output')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'taplo;lsp;help;tcp' {
            break
        }
        'taplo;lsp;help;stdio' {
            break
        }
        'taplo;lsp;help;help' {
            break
        }
        'taplo;config' {
            [CompletionResult]::new('--colors', 'colors', [CompletionResultType]::ParameterName, 'colors')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable a verbose logging format')
            [CompletionResult]::new('--log-spans', 'log-spans', [CompletionResultType]::ParameterName, 'Enable logging spans')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('default', 'default', [CompletionResultType]::ParameterValue, 'Print the default `.taplo.toml` configuration file')
            [CompletionResult]::new('schema', 'schema', [CompletionResultType]::ParameterValue, 'Print the JSON schema of the `.taplo.toml` configuration file')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'taplo;config;default' {
            [CompletionResult]::new('--colors', 'colors', [CompletionResultType]::ParameterName, 'colors')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable a verbose logging format')
            [CompletionResult]::new('--log-spans', 'log-spans', [CompletionResultType]::ParameterName, 'Enable logging spans')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'taplo;config;schema' {
            [CompletionResult]::new('--colors', 'colors', [CompletionResultType]::ParameterName, 'colors')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable a verbose logging format')
            [CompletionResult]::new('--log-spans', 'log-spans', [CompletionResultType]::ParameterName, 'Enable logging spans')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'taplo;config;help' {
            [CompletionResult]::new('default', 'default', [CompletionResultType]::ParameterValue, 'Print the default `.taplo.toml` configuration file')
            [CompletionResult]::new('schema', 'schema', [CompletionResultType]::ParameterValue, 'Print the JSON schema of the `.taplo.toml` configuration file')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'taplo;config;help;default' {
            break
        }
        'taplo;config;help;schema' {
            break
        }
        'taplo;config;help;help' {
            break
        }
        'taplo;get' {
            [CompletionResult]::new('-o', 'o', [CompletionResultType]::ParameterName, 'The format specifying how the output is printed')
            [CompletionResult]::new('--output-format', 'output-format', [CompletionResultType]::ParameterName, 'The format specifying how the output is printed')
            [CompletionResult]::new('-f', 'f', [CompletionResultType]::ParameterName, 'Path to the TOML document, if omitted the standard input will be used')
            [CompletionResult]::new('--file-path', 'file-path', [CompletionResultType]::ParameterName, 'Path to the TOML document, if omitted the standard input will be used')
            [CompletionResult]::new('--separator', 'separator', [CompletionResultType]::ParameterName, 'A string that separates array values when printing to stdout')
            [CompletionResult]::new('--colors', 'colors', [CompletionResultType]::ParameterName, 'colors')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Strip the trailing newline from the output')
            [CompletionResult]::new('--strip-newline', 'strip-newline', [CompletionResultType]::ParameterName, 'Strip the trailing newline from the output')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable a verbose logging format')
            [CompletionResult]::new('--log-spans', 'log-spans', [CompletionResultType]::ParameterName, 'Enable logging spans')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'taplo;toml-test' {
            [CompletionResult]::new('--colors', 'colors', [CompletionResultType]::ParameterName, 'colors')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable a verbose logging format')
            [CompletionResult]::new('--log-spans', 'log-spans', [CompletionResultType]::ParameterName, 'Enable logging spans')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'taplo;completions' {
            [CompletionResult]::new('--colors', 'colors', [CompletionResultType]::ParameterName, 'colors')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable a verbose logging format')
            [CompletionResult]::new('--log-spans', 'log-spans', [CompletionResultType]::ParameterName, 'Enable logging spans')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'taplo;help' {
            [CompletionResult]::new('lint', 'lint', [CompletionResultType]::ParameterValue, 'Lint TOML documents')
            [CompletionResult]::new('format', 'format', [CompletionResultType]::ParameterValue, 'Format TOML documents')
            [CompletionResult]::new('lsp', 'lsp', [CompletionResultType]::ParameterValue, 'Language server operations')
            [CompletionResult]::new('config', 'config', [CompletionResultType]::ParameterValue, 'Operations with the Taplo config file')
            [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Extract a value from the given TOML document')
            [CompletionResult]::new('toml-test', 'toml-test', [CompletionResultType]::ParameterValue, 'Start a decoder for `toml-test` (https://github.com/BurntSushi/toml-test)')
            [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate completions for Taplo CLI')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'taplo;help;lint' {
            break
        }
        'taplo;help;format' {
            break
        }
        'taplo;help;lsp' {
            [CompletionResult]::new('tcp', 'tcp', [CompletionResultType]::ParameterValue, 'Run the language server and listen on a TCP address')
            [CompletionResult]::new('stdio', 'stdio', [CompletionResultType]::ParameterValue, 'Run the language server over the standard input and output')
            break
        }
        'taplo;help;lsp;tcp' {
            break
        }
        'taplo;help;lsp;stdio' {
            break
        }
        'taplo;help;config' {
            [CompletionResult]::new('default', 'default', [CompletionResultType]::ParameterValue, 'Print the default `.taplo.toml` configuration file')
            [CompletionResult]::new('schema', 'schema', [CompletionResultType]::ParameterValue, 'Print the JSON schema of the `.taplo.toml` configuration file')
            break
        }
        'taplo;help;config;default' {
            break
        }
        'taplo;help;config;schema' {
            break
        }
        'taplo;help;get' {
            break
        }
        'taplo;help;toml-test' {
            break
        }
        'taplo;help;completions' {
            break
        }
        'taplo;help;help' {
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
