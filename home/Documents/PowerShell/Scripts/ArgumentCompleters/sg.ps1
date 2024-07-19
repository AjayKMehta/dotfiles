
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'sg.exe' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'sg.exe'
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
        'sg.exe' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('-V', 'V ', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Print version')
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
        'sg.exe;run' {
            [CompletionResult]::new('-p', 'p', [CompletionResultType]::ParameterName, 'AST pattern to match')
            [CompletionResult]::new('--pattern', 'pattern', [CompletionResultType]::ParameterName, 'AST pattern to match')
            [CompletionResult]::new('-r', 'r', [CompletionResultType]::ParameterName, 'String to replace the matched AST node')
            [CompletionResult]::new('--rewrite', 'rewrite', [CompletionResultType]::ParameterName, 'String to replace the matched AST node')
            [CompletionResult]::new('-l', 'l', [CompletionResultType]::ParameterName, 'The language of the pattern. Supported languages are: [Bash, C, Cpp, CSharp, Css, Dart, Elixir, Go, Haskell, Html, Java, JavaScript, Json, Kotlin, Lua, Php, Python, Ruby, Rust, Scala, Swift, Tsx, TypeScript]')
            [CompletionResult]::new('--lang', 'lang', [CompletionResultType]::ParameterName, 'The language of the pattern. Supported languages are: [Bash, C, Cpp, CSharp, Css, Dart, Elixir, Go, Haskell, Html, Java, JavaScript, Json, Kotlin, Lua, Php, Python, Ruby, Rust, Scala, Swift, Tsx, TypeScript]')
            [CompletionResult]::new('--debug-query', 'debug-query', [CompletionResultType]::ParameterName, 'Print query pattern''s tree-sitter AST. Requires lang be set explicitly')
            [CompletionResult]::new('--strictness', 'strictness', [CompletionResultType]::ParameterName, 'The strictness of the pattern')
            [CompletionResult]::new('--no-ignore', 'no-ignore', [CompletionResultType]::ParameterName, 'Do not respect hidden file system or ignore files (.gitignore, .ignore, etc.)')
            [CompletionResult]::new('--json', 'json', [CompletionResultType]::ParameterName, 'Output matches in structured JSON ')
            [CompletionResult]::new('--color', 'color', [CompletionResultType]::ParameterName, 'Controls output color')
            [CompletionResult]::new('--heading', 'heading', [CompletionResultType]::ParameterName, 'Controls whether to print the file name as heading')
            [CompletionResult]::new('-A', 'A ', [CompletionResultType]::ParameterName, 'Show NUM lines after each match')
            [CompletionResult]::new('--after', 'after', [CompletionResultType]::ParameterName, 'Show NUM lines after each match')
            [CompletionResult]::new('-B', 'B ', [CompletionResultType]::ParameterName, 'Show NUM lines before each match')
            [CompletionResult]::new('--before', 'before', [CompletionResultType]::ParameterName, 'Show NUM lines before each match')
            [CompletionResult]::new('-C', 'C ', [CompletionResultType]::ParameterName, 'Show NUM lines around each match')
            [CompletionResult]::new('--context', 'context', [CompletionResultType]::ParameterName, 'Show NUM lines around each match')
            [CompletionResult]::new('--stdin', 'stdin', [CompletionResultType]::ParameterName, 'Enable search code from StdIn')
            [CompletionResult]::new('-i', 'i', [CompletionResultType]::ParameterName, 'Start interactive edit session')
            [CompletionResult]::new('--interactive', 'interactive', [CompletionResultType]::ParameterName, 'Start interactive edit session')
            [CompletionResult]::new('-U', 'U ', [CompletionResultType]::ParameterName, 'Apply all rewrite without confirmation if true')
            [CompletionResult]::new('--update-all', 'update-all', [CompletionResultType]::ParameterName, 'Apply all rewrite without confirmation if true')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'sg.exe;scan' {
            [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('-r', 'r', [CompletionResultType]::ParameterName, 'Scan the codebase with the single rule located at the path RULE_FILE')
            [CompletionResult]::new('--rule', 'rule', [CompletionResultType]::ParameterName, 'Scan the codebase with the single rule located at the path RULE_FILE')
            [CompletionResult]::new('--inline-rules', 'inline-rules', [CompletionResultType]::ParameterName, 'Scan the codebase with a rule defined by the provided RULE_TEXT')
            [CompletionResult]::new('--filter', 'filter', [CompletionResultType]::ParameterName, 'Scan the codebase with rules with ids matching REGEX')
            [CompletionResult]::new('--format', 'format', [CompletionResultType]::ParameterName, 'Output warning/error messages in GitHub Action format')
            [CompletionResult]::new('--report-style', 'report-style', [CompletionResultType]::ParameterName, 'report-style')
            [CompletionResult]::new('--no-ignore', 'no-ignore', [CompletionResultType]::ParameterName, 'Do not respect hidden file system or ignore files (.gitignore, .ignore, etc.)')
            [CompletionResult]::new('--json', 'json', [CompletionResultType]::ParameterName, 'Output matches in structured JSON ')
            [CompletionResult]::new('--color', 'color', [CompletionResultType]::ParameterName, 'Controls output color')
            [CompletionResult]::new('--stdin', 'stdin', [CompletionResultType]::ParameterName, 'Enable search code from StdIn')
            [CompletionResult]::new('-i', 'i', [CompletionResultType]::ParameterName, 'Start interactive edit session')
            [CompletionResult]::new('--interactive', 'interactive', [CompletionResultType]::ParameterName, 'Start interactive edit session')
            [CompletionResult]::new('-U', 'U ', [CompletionResultType]::ParameterName, 'Apply all rewrite without confirmation if true')
            [CompletionResult]::new('--update-all', 'update-all', [CompletionResultType]::ParameterName, 'Apply all rewrite without confirmation if true')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'sg.exe;test' {
            [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Path to the root ast-grep config YAML')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Path to the root ast-grep config YAML')
            [CompletionResult]::new('-t', 't', [CompletionResultType]::ParameterName, 'the directories to search test YAML files')
            [CompletionResult]::new('--test-dir', 'test-dir', [CompletionResultType]::ParameterName, 'the directories to search test YAML files')
            [CompletionResult]::new('--snapshot-dir', 'snapshot-dir', [CompletionResultType]::ParameterName, 'Specify the directory name storing snapshots. Default to __snapshots__')
            [CompletionResult]::new('-f', 'f', [CompletionResultType]::ParameterName, 'Only run rule test cases that matches REGEX')
            [CompletionResult]::new('--filter', 'filter', [CompletionResultType]::ParameterName, 'Only run rule test cases that matches REGEX')
            [CompletionResult]::new('--skip-snapshot-tests', 'skip-snapshot-tests', [CompletionResultType]::ParameterName, 'Only check if the test code is valid, without checking rule output. Turn it on when you want to ignore the output of rules. Conflicts with --update-all')
            [CompletionResult]::new('-U', 'U ', [CompletionResultType]::ParameterName, 'Update the content of all snapshots that have changed in test. Conflicts with --skip-snapshot-tests')
            [CompletionResult]::new('--update-all', 'update-all', [CompletionResultType]::ParameterName, 'Update the content of all snapshots that have changed in test. Conflicts with --skip-snapshot-tests')
            [CompletionResult]::new('-i', 'i', [CompletionResultType]::ParameterName, 'Start an interactive review to update snapshots selectively')
            [CompletionResult]::new('--interactive', 'interactive', [CompletionResultType]::ParameterName, 'Start an interactive review to update snapshots selectively')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'sg.exe;new' {
            [CompletionResult]::new('-l', 'l', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('--lang', 'lang', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('-b', 'b', [CompletionResultType]::ParameterName, 'Create new project/items in the folder specified by this argument')
            [CompletionResult]::new('--base-dir', 'base-dir', [CompletionResultType]::ParameterName, 'Create new project/items in the folder specified by this argument')
            [CompletionResult]::new('-y', 'y', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('--yes', 'yes', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('project', 'project', [CompletionResultType]::ParameterValue, 'Create an new project by scaffolding')
            [CompletionResult]::new('rule', 'rule', [CompletionResultType]::ParameterValue, 'Create a new rule')
            [CompletionResult]::new('test', 'test', [CompletionResultType]::ParameterValue, 'Create a new test case')
            [CompletionResult]::new('util', 'util', [CompletionResultType]::ParameterValue, 'Create a new global utility rule')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'sg.exe;new;project' {
            [CompletionResult]::new('-l', 'l', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('--lang', 'lang', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('-b', 'b', [CompletionResultType]::ParameterName, 'Create new project/items in the folder specified by this argument')
            [CompletionResult]::new('--base-dir', 'base-dir', [CompletionResultType]::ParameterName, 'Create new project/items in the folder specified by this argument')
            [CompletionResult]::new('-y', 'y', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('--yes', 'yes', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'sg.exe;new;rule' {
            [CompletionResult]::new('-l', 'l', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('--lang', 'lang', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('-b', 'b', [CompletionResultType]::ParameterName, 'Create new project/items in the folder specified by this argument')
            [CompletionResult]::new('--base-dir', 'base-dir', [CompletionResultType]::ParameterName, 'Create new project/items in the folder specified by this argument')
            [CompletionResult]::new('-y', 'y', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('--yes', 'yes', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'sg.exe;new;test' {
            [CompletionResult]::new('-l', 'l', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('--lang', 'lang', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('-b', 'b', [CompletionResultType]::ParameterName, 'Create new project/items in the folder specified by this argument')
            [CompletionResult]::new('--base-dir', 'base-dir', [CompletionResultType]::ParameterName, 'Create new project/items in the folder specified by this argument')
            [CompletionResult]::new('-y', 'y', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('--yes', 'yes', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'sg.exe;new;util' {
            [CompletionResult]::new('-l', 'l', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('--lang', 'lang', [CompletionResultType]::ParameterName, 'The language of the item to create')
            [CompletionResult]::new('-b', 'b', [CompletionResultType]::ParameterName, 'Create new project/items in the folder specified by this argument')
            [CompletionResult]::new('--base-dir', 'base-dir', [CompletionResultType]::ParameterName, 'Create new project/items in the folder specified by this argument')
            [CompletionResult]::new('-y', 'y', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('--yes', 'yes', [CompletionResultType]::ParameterName, 'Accept all default options without interactive input during creation')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'sg.exe;new;help' {
            [CompletionResult]::new('project', 'project', [CompletionResultType]::ParameterValue, 'Create an new project by scaffolding')
            [CompletionResult]::new('rule', 'rule', [CompletionResultType]::ParameterValue, 'Create a new rule')
            [CompletionResult]::new('test', 'test', [CompletionResultType]::ParameterValue, 'Create a new test case')
            [CompletionResult]::new('util', 'util', [CompletionResultType]::ParameterValue, 'Create a new global utility rule')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'sg.exe;new;help;project' {
            break
        }
        'sg.exe;new;help;rule' {
            break
        }
        'sg.exe;new;help;test' {
            break
        }
        'sg.exe;new;help;util' {
            break
        }
        'sg.exe;new;help;help' {
            break
        }
        'sg.exe;lsp' {
            [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Path to ast-grep root config, default is sgconfig.yml')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'sg.exe;completions' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'sg.exe;docs' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'sg.exe;help' {
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
        'sg.exe;help;run' {
            break
        }
        'sg.exe;help;scan' {
            break
        }
        'sg.exe;help;test' {
            break
        }
        'sg.exe;help;new' {
            [CompletionResult]::new('project', 'project', [CompletionResultType]::ParameterValue, 'Create an new project by scaffolding')
            [CompletionResult]::new('rule', 'rule', [CompletionResultType]::ParameterValue, 'Create a new rule')
            [CompletionResult]::new('test', 'test', [CompletionResultType]::ParameterValue, 'Create a new test case')
            [CompletionResult]::new('util', 'util', [CompletionResultType]::ParameterValue, 'Create a new global utility rule')
            break
        }
        'sg.exe;help;new;project' {
            break
        }
        'sg.exe;help;new;rule' {
            break
        }
        'sg.exe;help;new;test' {
            break
        }
        'sg.exe;help;new;util' {
            break
        }
        'sg.exe;help;lsp' {
            break
        }
        'sg.exe;help;completions' {
            break
        }
        'sg.exe;help;docs' {
            break
        }
        'sg.exe;help;help' {
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
