
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'ast-grep' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'ast-grep'
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
        'ast-grep' {
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('-V', '-V ', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('--version', '--version', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Run one time search or rewrite in command line. (default command)')
            [CompletionResult]::new('scan', 'scan', [CompletionResultType]::ParameterValue, 'Scan and rewrite code by configuration')
            [CompletionResult]::new('test', 'test', [CompletionResultType]::ParameterValue, 'Test ast-grep rules')
            [CompletionResult]::new('new', 'new', [CompletionResultType]::ParameterValue, 'Create new ast-grep project or items like rules/tests')
            [CompletionResult]::new('lsp', 'lsp', [CompletionResultType]::ParameterValue, 'Start language server')
            [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate shell completion script')
            [CompletionResult]::new('docs', 'docs', [CompletionResultType]::ParameterValue, 'Generate rule docs for current configuration. (Not Implemented Yet)')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ast-grep;run' {
            [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'AST pattern to match')
            [CompletionResult]::new('--pattern', '--pattern', [CompletionResultType]::ParameterName, 'AST pattern to match')
            [CompletionResult]::new('--selector', '--selector', [CompletionResultType]::ParameterName, 'AST kind to extract sub-part of pattern to match')
            [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'String to replace the matched AST node')
            [CompletionResult]::new('--rewrite', '--rewrite', [CompletionResultType]::ParameterName, 'String to replace the matched AST node')
            [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'The language of the pattern. Supported languages are: [Bash, C, Cpp, CSharp, Css, Elixir, Go, Haskell, Html, Java, JavaScript, Json, Kotlin, Lua, Php, Python, Ruby, Rust, Scala, Swift, Tsx, TypeScript, Yaml]')
            [CompletionResult]::new('--lang', '--lang', [CompletionResultType]::ParameterName, 'The language of the pattern. Supported languages are: [Bash, C, Cpp, CSharp, Css, Elixir, Go, Haskell, Html, Java, JavaScript, Json, Kotlin, Lua, Php, Python, Ruby, Rust, Scala, Swift, Tsx, TypeScript, Yaml]')
            [CompletionResult]::new('--debug-query', '--debug-query', [CompletionResultType]::ParameterName, 'Print query pattern''s tree-sitter AST. Requires lang be set explicitly')
            [CompletionResult]::new('--strictness', '--strictness', [CompletionResultType]::ParameterName, 'The strictness of the pattern')
            [CompletionResult]::new('--no-ignore', '--no-ignore', [CompletionResultType]::ParameterName, 'Do not respect hidden file system or ignore files (.gitignore, .ignore, etc.)')
            [CompletionResult]::new('--globs', '--globs', [CompletionResultType]::ParameterName, 'Include or exclude file paths')
            [CompletionResult]::new('-j', '-j', [CompletionResultType]::ParameterName, 'Set the approximate number of threads to use')
            [CompletionResult]::new('--threads', '--threads', [CompletionResultType]::ParameterName, 'Set the approximate number of threads to use')
            [CompletionResult]::new('--json', '--json', [CompletionResultType]::ParameterName, 'Output matches in structured JSON ')
            [CompletionResult]::new('--color', '--color', [CompletionResultType]::ParameterName, 'Controls output color')
            [CompletionResult]::new('--inspect', '--inspect', [CompletionResultType]::ParameterName, 'Inspect information for file/rule discovery and scanning')
            [CompletionResult]::new('-A', '-A ', [CompletionResultType]::ParameterName, 'Show NUM lines after each match')
            [CompletionResult]::new('--after', '--after', [CompletionResultType]::ParameterName, 'Show NUM lines after each match')
            [CompletionResult]::new('-B', '-B ', [CompletionResultType]::ParameterName, 'Show NUM lines before each match')
            [CompletionResult]::new('--before', '--before', [CompletionResultType]::ParameterName, 'Show NUM lines before each match')
            [CompletionResult]::new('-C', '-C ', [CompletionResultType]::ParameterName, 'Show NUM lines around each match')
            [CompletionResult]::new('--context', '--context', [CompletionResultType]::ParameterName, 'Show NUM lines around each match')
            [CompletionResult]::new('--heading', '--heading', [CompletionResultType]::ParameterName, 'Controls whether to print the file name as heading')
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--follow', '--follow', [CompletionResultType]::ParameterName, 'Follow symbolic links')
            [CompletionResult]::new('--stdin', '--stdin', [CompletionResultType]::ParameterName, 'Enable search code from StdIn')
            [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Start interactive edit session')
            [CompletionResult]::new('--interactive', '--interactive', [CompletionResultType]::ParameterName, 'Start interactive edit session')
            [CompletionResult]::new('-U', '-U ', [CompletionResultType]::ParameterName, 'Apply all rewrite without confirmation if true')
            [CompletionResult]::new('--update-all', '--update-all', [CompletionResultType]::ParameterName, 'Apply all rewrite without confirmation if true')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ast-grep;scan' {
            [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Scan the codebase with the single rule located at the path RULE_FILE')
            [CompletionResult]::new('--rule', '--rule', [CompletionResultType]::ParameterName, 'Scan the codebase with the single rule located at the path RULE_FILE')
            [CompletionResult]::new('--inline-rules', '--inline-rules', [CompletionResultType]::ParameterName, 'Scan the codebase with a rule defined by the provided RULE_TEXT')
            [CompletionResult]::new('--format', '--format', [CompletionResultType]::ParameterName, 'Output warning/error messages in GitHub Action format')
            [CompletionResult]::new('--report-style', '--report-style', [CompletionResultType]::ParameterName, 'report-style')
            [CompletionResult]::new('--filter', '--filter', [CompletionResultType]::ParameterName, 'Scan the codebase with rules with ids matching REGEX')
            [CompletionResult]::new('--error', '--error', [CompletionResultType]::ParameterName, 'Set rule severity to error')
            [CompletionResult]::new('--warning', '--warning', [CompletionResultType]::ParameterName, 'Set rule severity to warning')
            [CompletionResult]::new('--info', '--info', [CompletionResultType]::ParameterName, 'Set rule severity to info')
            [CompletionResult]::new('--hint', '--hint', [CompletionResultType]::ParameterName, 'Set rule severity to hint')
            [CompletionResult]::new('--off', '--off', [CompletionResultType]::ParameterName, 'Turn off rule')
            [CompletionResult]::new('--no-ignore', '--no-ignore', [CompletionResultType]::ParameterName, 'Do not respect hidden file system or ignore files (.gitignore, .ignore, etc.)')
            [CompletionResult]::new('--globs', '--globs', [CompletionResultType]::ParameterName, 'Include or exclude file paths')
            [CompletionResult]::new('-j', '-j', [CompletionResultType]::ParameterName, 'Set the approximate number of threads to use')
            [CompletionResult]::new('--threads', '--threads', [CompletionResultType]::ParameterName, 'Set the approximate number of threads to use')
            [CompletionResult]::new('--json', '--json', [CompletionResultType]::ParameterName, 'Output matches in structured JSON ')
            [CompletionResult]::new('--color', '--color', [CompletionResultType]::ParameterName, 'Controls output color')
            [CompletionResult]::new('--inspect', '--inspect', [CompletionResultType]::ParameterName, 'Inspect information for file/rule discovery and scanning')
            [CompletionResult]::new('-A', '-A ', [CompletionResultType]::ParameterName, 'Show NUM lines after each match')
            [CompletionResult]::new('--after', '--after', [CompletionResultType]::ParameterName, 'Show NUM lines after each match')
            [CompletionResult]::new('-B', '-B ', [CompletionResultType]::ParameterName, 'Show NUM lines before each match')
            [CompletionResult]::new('--before', '--before', [CompletionResultType]::ParameterName, 'Show NUM lines before each match')
            [CompletionResult]::new('-C', '-C ', [CompletionResultType]::ParameterName, 'Show NUM lines around each match')
            [CompletionResult]::new('--context', '--context', [CompletionResultType]::ParameterName, 'Show NUM lines around each match')
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--include-metadata', '--include-metadata', [CompletionResultType]::ParameterName, 'Include rule metadata in the json output')
            [CompletionResult]::new('--follow', '--follow', [CompletionResultType]::ParameterName, 'Follow symbolic links')
            [CompletionResult]::new('--stdin', '--stdin', [CompletionResultType]::ParameterName, 'Enable search code from StdIn')
            [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Start interactive edit session')
            [CompletionResult]::new('--interactive', '--interactive', [CompletionResultType]::ParameterName, 'Start interactive edit session')
            [CompletionResult]::new('-U', '-U ', [CompletionResultType]::ParameterName, 'Apply all rewrite without confirmation if true')
            [CompletionResult]::new('--update-all', '--update-all', [CompletionResultType]::ParameterName, 'Apply all rewrite without confirmation if true')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ast-grep;test' {
            [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'the directories to search test YAML files')
            [CompletionResult]::new('--test-dir', '--test-dir', [CompletionResultType]::ParameterName, 'the directories to search test YAML files')
            [CompletionResult]::new('--snapshot-dir', '--snapshot-dir', [CompletionResultType]::ParameterName, 'Specify the directory name storing snapshots. Default to __snapshots__')
            [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Only run rule test cases that matches REGEX')
            [CompletionResult]::new('--filter', '--filter', [CompletionResultType]::ParameterName, 'Only run rule test cases that matches REGEX')
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--skip-snapshot-tests', '--skip-snapshot-tests', [CompletionResultType]::ParameterName, 'Only check if the test code is valid, without checking rule output. Turn it on when you want to ignore the output of rules. Conflicts with --update-all')
            [CompletionResult]::new('-U', '-U ', [CompletionResultType]::ParameterName, 'Update the content of all snapshots that have changed in test. Conflicts with --skip-snapshot-tests')
            [CompletionResult]::new('--update-all', '--update-all', [CompletionResultType]::ParameterName, 'Update the content of all snapshots that have changed in test. Conflicts with --skip-snapshot-tests')
            [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Start an interactive review to update snapshots selectively')
            [CompletionResult]::new('--interactive', '--interactive', [CompletionResultType]::ParameterName, 'Start an interactive review to update snapshots selectively')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ast-grep;new' {
            [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('--lang', '--lang', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('-y', '-y', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('--yes', '--yes', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('project', 'project', [CompletionResultType]::ParameterValue, 'Create an new project by scaffolding')
            [CompletionResult]::new('rule', 'rule', [CompletionResultType]::ParameterValue, 'Create a new rule')
            [CompletionResult]::new('test', 'test', [CompletionResultType]::ParameterValue, 'Create a new test case')
            [CompletionResult]::new('util', 'util', [CompletionResultType]::ParameterValue, 'Create a new global utility rule')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ast-grep;new;project' {
            [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('--lang', '--lang', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('-y', '-y', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('--yes', '--yes', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ast-grep;new;rule' {
            [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('--lang', '--lang', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('-y', '-y', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('--yes', '--yes', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ast-grep;new;test' {
            [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('--lang', '--lang', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('-y', '-y', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('--yes', '--yes', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ast-grep;new;util' {
            [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('--lang', '--lang', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('-y', '-y', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('--yes', '--yes', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ast-grep;new;help' {
            [CompletionResult]::new('project', 'project', [CompletionResultType]::ParameterValue, 'Create an new project by scaffolding')
            [CompletionResult]::new('rule', 'rule', [CompletionResultType]::ParameterValue, 'Create a new rule')
            [CompletionResult]::new('test', 'test', [CompletionResultType]::ParameterValue, 'Create a new test case')
            [CompletionResult]::new('util', 'util', [CompletionResultType]::ParameterValue, 'Create a new global utility rule')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ast-grep;new;help;project' {
            break
        }
        'ast-grep;new;help;rule' {
            break
        }
        'ast-grep;new;help;test' {
            break
        }
        'ast-grep;new;help;util' {
            break
        }
        'ast-grep;new;help;help' {
            break
        }
        'ast-grep;lsp' {
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ast-grep;completions' {
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ast-grep;docs' {
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ast-grep;help' {
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Run one time search or rewrite in command line. (default command)')
            [CompletionResult]::new('scan', 'scan', [CompletionResultType]::ParameterValue, 'Scan and rewrite code by configuration')
            [CompletionResult]::new('test', 'test', [CompletionResultType]::ParameterValue, 'Test ast-grep rules')
            [CompletionResult]::new('new', 'new', [CompletionResultType]::ParameterValue, 'Create new ast-grep project or items like rules/tests')
            [CompletionResult]::new('lsp', 'lsp', [CompletionResultType]::ParameterValue, 'Start language server')
            [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate shell completion script')
            [CompletionResult]::new('docs', 'docs', [CompletionResultType]::ParameterValue, 'Generate rule docs for current configuration. (Not Implemented Yet)')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ast-grep;help;run' {
            break
        }
        'ast-grep;help;scan' {
            break
        }
        'ast-grep;help;test' {
            break
        }
        'ast-grep;help;new' {
            [CompletionResult]::new('project', 'project', [CompletionResultType]::ParameterValue, 'Create an new project by scaffolding')
            [CompletionResult]::new('rule', 'rule', [CompletionResultType]::ParameterValue, 'Create a new rule')
            [CompletionResult]::new('test', 'test', [CompletionResultType]::ParameterValue, 'Create a new test case')
            [CompletionResult]::new('util', 'util', [CompletionResultType]::ParameterValue, 'Create a new global utility rule')
            break
        }
        'ast-grep;help;new;project' {
            break
        }
        'ast-grep;help;new;rule' {
            break
        }
        'ast-grep;help;new;test' {
            break
        }
        'ast-grep;help;new;util' {
            break
        }
        'ast-grep;help;lsp' {
            break
        }
        'ast-grep;help;completions' {
            break
        }
        'ast-grep;help;docs' {
            break
        }
        'ast-grep;help;help' {
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
