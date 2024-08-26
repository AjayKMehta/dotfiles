
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'ruff' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'ruff'
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
        'ruff' {
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Either a path to a TOML configuration file (`pyproject.toml` or `ruff.toml`), or a TOML `<KEY> = <VALUE>` pair (such as you might find in a `ruff.toml` configuration file) overriding a specific configuration option. Overrides of individual settings using this option always take precedence over all configuration files, including configuration files that were also specified using `--config`')
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('-q', 'q', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('--quiet', 'quiet', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--silent', 'silent', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--isolated', 'isolated', [CompletionResultType]::ParameterName, 'Ignore all configuration files')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('-V', 'V ', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('check', 'check', [CompletionResultType]::ParameterValue, 'Run Ruff on the given files or directories (default)')
            [CompletionResult]::new('rule', 'rule', [CompletionResultType]::ParameterValue, 'Explain a rule (or all rules)')
            [CompletionResult]::new('config', 'config', [CompletionResultType]::ParameterValue, 'List or describe the available configuration options')
            [CompletionResult]::new('linter', 'linter', [CompletionResultType]::ParameterValue, 'List all supported upstream linters')
            [CompletionResult]::new('clean', 'clean', [CompletionResultType]::ParameterValue, 'Clear any caches in the current directory and any subdirectories')
            [CompletionResult]::new('generate-shell-completion', 'generate-shell-completion', [CompletionResultType]::ParameterValue, 'Generate shell completion')
            [CompletionResult]::new('format', 'format', [CompletionResultType]::ParameterValue, 'Run the Ruff formatter on the given files or directories')
            [CompletionResult]::new('server', 'server', [CompletionResultType]::ParameterValue, 'Run the language server')
            [CompletionResult]::new('version', 'version', [CompletionResultType]::ParameterValue, 'Display Ruff''s version')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ruff;check' {
            [CompletionResult]::new('--output-format', 'output-format', [CompletionResultType]::ParameterName, 'Output serialization format for violations. The default serialization format is "full"')
            [CompletionResult]::new('-o', 'o', [CompletionResultType]::ParameterName, 'Specify file to write the linter output to (default: stdout)')
            [CompletionResult]::new('--output-file', 'output-file', [CompletionResultType]::ParameterName, 'Specify file to write the linter output to (default: stdout)')
            [CompletionResult]::new('--target-version', 'target-version', [CompletionResultType]::ParameterName, 'The minimum Python version that should be supported')
            [CompletionResult]::new('--select', 'select', [CompletionResultType]::ParameterName, 'Comma-separated list of rule codes to enable (or ALL, to enable all rules)')
            [CompletionResult]::new('--ignore', 'ignore', [CompletionResultType]::ParameterName, 'Comma-separated list of rule codes to disable')
            [CompletionResult]::new('--extend-select', 'extend-select', [CompletionResultType]::ParameterName, 'Like --select, but adds additional rule codes on top of those already specified')
            [CompletionResult]::new('--extend-ignore', 'extend-ignore', [CompletionResultType]::ParameterName, 'Like --ignore. (Deprecated: You can just use --ignore instead.)')
            [CompletionResult]::new('--per-file-ignores', 'per-file-ignores', [CompletionResultType]::ParameterName, 'List of mappings from file pattern to code to exclude')
            [CompletionResult]::new('--extend-per-file-ignores', 'extend-per-file-ignores', [CompletionResultType]::ParameterName, 'Like `--per-file-ignores`, but adds additional ignores on top of those already specified')
            [CompletionResult]::new('--exclude', 'exclude', [CompletionResultType]::ParameterName, 'List of paths, used to omit files and/or directories from analysis')
            [CompletionResult]::new('--extend-exclude', 'extend-exclude', [CompletionResultType]::ParameterName, 'Like --exclude, but adds additional files and directories on top of those already excluded')
            [CompletionResult]::new('--fixable', 'fixable', [CompletionResultType]::ParameterName, 'List of rule codes to treat as eligible for fix. Only applicable when fix itself is enabled (e.g., via `--fix`)')
            [CompletionResult]::new('--unfixable', 'unfixable', [CompletionResultType]::ParameterName, 'List of rule codes to treat as ineligible for fix. Only applicable when fix itself is enabled (e.g., via `--fix`)')
            [CompletionResult]::new('--extend-fixable', 'extend-fixable', [CompletionResultType]::ParameterName, 'Like --fixable, but adds additional rule codes on top of those already specified')
            [CompletionResult]::new('--extend-unfixable', 'extend-unfixable', [CompletionResultType]::ParameterName, 'Like --unfixable. (Deprecated: You can just use --unfixable instead.)')
            [CompletionResult]::new('--line-length', 'line-length', [CompletionResultType]::ParameterName, 'Set the line-length for length-associated rules and automatic formatting')
            [CompletionResult]::new('--dummy-variable-rgx', 'dummy-variable-rgx', [CompletionResultType]::ParameterName, 'Regular expression matching the name of dummy variables')
            [CompletionResult]::new('--cache-dir', 'cache-dir', [CompletionResultType]::ParameterName, 'Path to the cache directory')
            [CompletionResult]::new('--stdin-filename', 'stdin-filename', [CompletionResultType]::ParameterName, 'The name of the file when passing it through stdin')
            [CompletionResult]::new('--extension', 'extension', [CompletionResultType]::ParameterName, 'List of mappings from file extension to language (one of `python`, `ipynb`, `pyi`). For example, to treat `.ipy` files as IPython notebooks, use `--extension ipy:ipynb`')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Either a path to a TOML configuration file (`pyproject.toml` or `ruff.toml`), or a TOML `<KEY> = <VALUE>` pair (such as you might find in a `ruff.toml` configuration file) overriding a specific configuration option. Overrides of individual settings using this option always take precedence over all configuration files, including configuration files that were also specified using `--config`')
            [CompletionResult]::new('--fix', 'fix', [CompletionResultType]::ParameterName, 'Apply fixes to resolve lint violations. Use `--no-fix` to disable or `--unsafe-fixes` to include unsafe fixes')
            [CompletionResult]::new('--no-fix', 'no-fix', [CompletionResultType]::ParameterName, 'no-fix')
            [CompletionResult]::new('--unsafe-fixes', 'unsafe-fixes', [CompletionResultType]::ParameterName, 'Include fixes that may not retain the original intent of the code. Use `--no-unsafe-fixes` to disable')
            [CompletionResult]::new('--no-unsafe-fixes', 'no-unsafe-fixes', [CompletionResultType]::ParameterName, 'no-unsafe-fixes')
            [CompletionResult]::new('--show-fixes', 'show-fixes', [CompletionResultType]::ParameterName, 'Show an enumeration of all fixed lint violations. Use `--no-show-fixes` to disable')
            [CompletionResult]::new('--no-show-fixes', 'no-show-fixes', [CompletionResultType]::ParameterName, 'no-show-fixes')
            [CompletionResult]::new('--diff', 'diff', [CompletionResultType]::ParameterName, 'Avoid writing any fixed files back; instead, output a diff for each changed file to stdout, and exit 0 if there are no diffs. Implies `--fix-only`')
            [CompletionResult]::new('-w', 'w', [CompletionResultType]::ParameterName, 'Run in watch mode by re-running whenever files change')
            [CompletionResult]::new('--watch', 'watch', [CompletionResultType]::ParameterName, 'Run in watch mode by re-running whenever files change')
            [CompletionResult]::new('--fix-only', 'fix-only', [CompletionResultType]::ParameterName, 'Apply fixes to resolve lint violations, but don''t report on, or exit non-zero for, leftover violations. Implies `--fix`. Use `--no-fix-only` to disable or `--unsafe-fixes` to include unsafe fixes')
            [CompletionResult]::new('--no-fix-only', 'no-fix-only', [CompletionResultType]::ParameterName, 'no-fix-only')
            [CompletionResult]::new('--ignore-noqa', 'ignore-noqa', [CompletionResultType]::ParameterName, 'Ignore any `# noqa` comments')
            [CompletionResult]::new('--preview', 'preview', [CompletionResultType]::ParameterName, 'Enable preview mode; checks will include unstable rules and fixes. Use `--no-preview` to disable')
            [CompletionResult]::new('--no-preview', 'no-preview', [CompletionResultType]::ParameterName, 'no-preview')
            [CompletionResult]::new('--respect-gitignore', 'respect-gitignore', [CompletionResultType]::ParameterName, 'Respect file exclusions via `.gitignore` and other standard ignore files. Use `--no-respect-gitignore` to disable')
            [CompletionResult]::new('--no-respect-gitignore', 'no-respect-gitignore', [CompletionResultType]::ParameterName, 'no-respect-gitignore')
            [CompletionResult]::new('--force-exclude', 'force-exclude', [CompletionResultType]::ParameterName, 'Enforce exclusions, even for paths passed to Ruff directly on the command-line. Use `--no-force-exclude` to disable')
            [CompletionResult]::new('--no-force-exclude', 'no-force-exclude', [CompletionResultType]::ParameterName, 'no-force-exclude')
            [CompletionResult]::new('-n', 'n', [CompletionResultType]::ParameterName, 'Disable cache reads')
            [CompletionResult]::new('--no-cache', 'no-cache', [CompletionResultType]::ParameterName, 'Disable cache reads')
            [CompletionResult]::new('-e', 'e', [CompletionResultType]::ParameterName, 'Exit with status code "0", even upon detecting lint violations')
            [CompletionResult]::new('--exit-zero', 'exit-zero', [CompletionResultType]::ParameterName, 'Exit with status code "0", even upon detecting lint violations')
            [CompletionResult]::new('--exit-non-zero-on-fix', 'exit-non-zero-on-fix', [CompletionResultType]::ParameterName, 'Exit with a non-zero status code if any files were modified via fix, even if no lint violations remain')
            [CompletionResult]::new('--statistics', 'statistics', [CompletionResultType]::ParameterName, 'Show counts for every rule with at least one violation')
            [CompletionResult]::new('--add-noqa', 'add-noqa', [CompletionResultType]::ParameterName, 'Enable automatic additions of `noqa` directives to failing lines')
            [CompletionResult]::new('--show-files', 'show-files', [CompletionResultType]::ParameterName, 'See the files Ruff will be run against with the current settings')
            [CompletionResult]::new('--show-settings', 'show-settings', [CompletionResultType]::ParameterName, 'See the settings Ruff will use to lint a given Python file')
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('-q', 'q', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('--quiet', 'quiet', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--silent', 'silent', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--isolated', 'isolated', [CompletionResultType]::ParameterName, 'Ignore all configuration files')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ruff;rule' {
            [CompletionResult]::new('--output-format', 'output-format', [CompletionResultType]::ParameterName, 'Output format')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Either a path to a TOML configuration file (`pyproject.toml` or `ruff.toml`), or a TOML `<KEY> = <VALUE>` pair (such as you might find in a `ruff.toml` configuration file) overriding a specific configuration option. Overrides of individual settings using this option always take precedence over all configuration files, including configuration files that were also specified using `--config`')
            [CompletionResult]::new('--all', 'all', [CompletionResultType]::ParameterName, 'Explain all rules')
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('-q', 'q', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('--quiet', 'quiet', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--silent', 'silent', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--isolated', 'isolated', [CompletionResultType]::ParameterName, 'Ignore all configuration files')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ruff;config' {
            [CompletionResult]::new('--output-format', 'output-format', [CompletionResultType]::ParameterName, 'Output format')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Either a path to a TOML configuration file (`pyproject.toml` or `ruff.toml`), or a TOML `<KEY> = <VALUE>` pair (such as you might find in a `ruff.toml` configuration file) overriding a specific configuration option. Overrides of individual settings using this option always take precedence over all configuration files, including configuration files that were also specified using `--config`')
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('-q', 'q', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('--quiet', 'quiet', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--silent', 'silent', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--isolated', 'isolated', [CompletionResultType]::ParameterName, 'Ignore all configuration files')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ruff;linter' {
            [CompletionResult]::new('--output-format', 'output-format', [CompletionResultType]::ParameterName, 'Output format')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Either a path to a TOML configuration file (`pyproject.toml` or `ruff.toml`), or a TOML `<KEY> = <VALUE>` pair (such as you might find in a `ruff.toml` configuration file) overriding a specific configuration option. Overrides of individual settings using this option always take precedence over all configuration files, including configuration files that were also specified using `--config`')
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('-q', 'q', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('--quiet', 'quiet', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--silent', 'silent', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--isolated', 'isolated', [CompletionResultType]::ParameterName, 'Ignore all configuration files')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ruff;clean' {
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Either a path to a TOML configuration file (`pyproject.toml` or `ruff.toml`), or a TOML `<KEY> = <VALUE>` pair (such as you might find in a `ruff.toml` configuration file) overriding a specific configuration option. Overrides of individual settings using this option always take precedence over all configuration files, including configuration files that were also specified using `--config`')
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('-q', 'q', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('--quiet', 'quiet', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--silent', 'silent', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--isolated', 'isolated', [CompletionResultType]::ParameterName, 'Ignore all configuration files')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ruff;generate-shell-completion' {
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Either a path to a TOML configuration file (`pyproject.toml` or `ruff.toml`), or a TOML `<KEY> = <VALUE>` pair (such as you might find in a `ruff.toml` configuration file) overriding a specific configuration option. Overrides of individual settings using this option always take precedence over all configuration files, including configuration files that were also specified using `--config`')
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('-q', 'q', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('--quiet', 'quiet', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--silent', 'silent', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--isolated', 'isolated', [CompletionResultType]::ParameterName, 'Ignore all configuration files')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ruff;format' {
            [CompletionResult]::new('--cache-dir', 'cache-dir', [CompletionResultType]::ParameterName, 'Path to the cache directory')
            [CompletionResult]::new('--exclude', 'exclude', [CompletionResultType]::ParameterName, 'List of paths, used to omit files and/or directories from analysis')
            [CompletionResult]::new('--line-length', 'line-length', [CompletionResultType]::ParameterName, 'Set the line-length')
            [CompletionResult]::new('--stdin-filename', 'stdin-filename', [CompletionResultType]::ParameterName, 'The name of the file when passing it through stdin')
            [CompletionResult]::new('--extension', 'extension', [CompletionResultType]::ParameterName, 'List of mappings from file extension to language (one of `python`, `ipynb`, `pyi`). For example, to treat `.ipy` files as IPython notebooks, use `--extension ipy:ipynb`')
            [CompletionResult]::new('--target-version', 'target-version', [CompletionResultType]::ParameterName, 'The minimum Python version that should be supported')
            [CompletionResult]::new('--range', 'range', [CompletionResultType]::ParameterName, 'When specified, Ruff will try to only format the code in the given range. It might be necessary to extend the start backwards or the end forwards, to fully enclose a logical line. The `<RANGE>` uses the format `<start_line>:<start_column>-<end_line>:<end_column>`.')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Either a path to a TOML configuration file (`pyproject.toml` or `ruff.toml`), or a TOML `<KEY> = <VALUE>` pair (such as you might find in a `ruff.toml` configuration file) overriding a specific configuration option. Overrides of individual settings using this option always take precedence over all configuration files, including configuration files that were also specified using `--config`')
            [CompletionResult]::new('--check', 'check', [CompletionResultType]::ParameterName, 'Avoid writing any formatted files back; instead, exit with a non-zero status code if any files would have been modified, and zero otherwise')
            [CompletionResult]::new('--diff', 'diff', [CompletionResultType]::ParameterName, 'Avoid writing any formatted files back; instead, exit with a non-zero status code and the difference between the current file and how the formatted file would look like')
            [CompletionResult]::new('-n', 'n', [CompletionResultType]::ParameterName, 'Disable cache reads')
            [CompletionResult]::new('--no-cache', 'no-cache', [CompletionResultType]::ParameterName, 'Disable cache reads')
            [CompletionResult]::new('--respect-gitignore', 'respect-gitignore', [CompletionResultType]::ParameterName, 'Respect file exclusions via `.gitignore` and other standard ignore files. Use `--no-respect-gitignore` to disable')
            [CompletionResult]::new('--no-respect-gitignore', 'no-respect-gitignore', [CompletionResultType]::ParameterName, 'no-respect-gitignore')
            [CompletionResult]::new('--force-exclude', 'force-exclude', [CompletionResultType]::ParameterName, 'Enforce exclusions, even for paths passed to Ruff directly on the command-line. Use `--no-force-exclude` to disable')
            [CompletionResult]::new('--no-force-exclude', 'no-force-exclude', [CompletionResultType]::ParameterName, 'no-force-exclude')
            [CompletionResult]::new('--preview', 'preview', [CompletionResultType]::ParameterName, 'Enable preview mode; enables unstable formatting. Use `--no-preview` to disable')
            [CompletionResult]::new('--no-preview', 'no-preview', [CompletionResultType]::ParameterName, 'no-preview')
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('-q', 'q', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('--quiet', 'quiet', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--silent', 'silent', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--isolated', 'isolated', [CompletionResultType]::ParameterName, 'Ignore all configuration files')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ruff;server' {
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Either a path to a TOML configuration file (`pyproject.toml` or `ruff.toml`), or a TOML `<KEY> = <VALUE>` pair (such as you might find in a `ruff.toml` configuration file) overriding a specific configuration option. Overrides of individual settings using this option always take precedence over all configuration files, including configuration files that were also specified using `--config`')
            [CompletionResult]::new('--preview', 'preview', [CompletionResultType]::ParameterName, 'Enable preview mode. Use `--no-preview` to disable')
            [CompletionResult]::new('--no-preview', 'no-preview', [CompletionResultType]::ParameterName, 'no-preview')
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('-q', 'q', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('--quiet', 'quiet', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--silent', 'silent', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--isolated', 'isolated', [CompletionResultType]::ParameterName, 'Ignore all configuration files')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ruff;version' {
            [CompletionResult]::new('--output-format', 'output-format', [CompletionResultType]::ParameterName, 'output-format')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Either a path to a TOML configuration file (`pyproject.toml` or `ruff.toml`), or a TOML `<KEY> = <VALUE>` pair (such as you might find in a `ruff.toml` configuration file) overriding a specific configuration option. Overrides of individual settings using this option always take precedence over all configuration files, including configuration files that were also specified using `--config`')
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable verbose logging')
            [CompletionResult]::new('-q', 'q', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('--quiet', 'quiet', [CompletionResultType]::ParameterName, 'Print diagnostics, but nothing else')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--silent', 'silent', [CompletionResultType]::ParameterName, 'Disable all logging (but still exit with status code "1" upon detecting diagnostics)')
            [CompletionResult]::new('--isolated', 'isolated', [CompletionResultType]::ParameterName, 'Ignore all configuration files')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ruff;help' {
            [CompletionResult]::new('check', 'check', [CompletionResultType]::ParameterValue, 'Run Ruff on the given files or directories (default)')
            [CompletionResult]::new('rule', 'rule', [CompletionResultType]::ParameterValue, 'Explain a rule (or all rules)')
            [CompletionResult]::new('config', 'config', [CompletionResultType]::ParameterValue, 'List or describe the available configuration options')
            [CompletionResult]::new('linter', 'linter', [CompletionResultType]::ParameterValue, 'List all supported upstream linters')
            [CompletionResult]::new('clean', 'clean', [CompletionResultType]::ParameterValue, 'Clear any caches in the current directory and any subdirectories')
            [CompletionResult]::new('generate-shell-completion', 'generate-shell-completion', [CompletionResultType]::ParameterValue, 'Generate shell completion')
            [CompletionResult]::new('format', 'format', [CompletionResultType]::ParameterValue, 'Run the Ruff formatter on the given files or directories')
            [CompletionResult]::new('server', 'server', [CompletionResultType]::ParameterValue, 'Run the language server')
            [CompletionResult]::new('version', 'version', [CompletionResultType]::ParameterValue, 'Display Ruff''s version')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ruff;help;check' {
            break
        }
        'ruff;help;rule' {
            break
        }
        'ruff;help;config' {
            break
        }
        'ruff;help;linter' {
            break
        }
        'ruff;help;clean' {
            break
        }
        'ruff;help;generate-shell-completion' {
            break
        }
        'ruff;help;format' {
            break
        }
        'ruff;help;server' {
            break
        }
        'ruff;help;version' {
            break
        }
        'ruff;help;help' {
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
