
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'uvx' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'uvx'
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
        'uvx' {
            [CompletionResult]::new('--from', '--from', [CompletionResultType]::ParameterName, 'Use the given package to provide the command')
            [CompletionResult]::new('--with', '--with', [CompletionResultType]::ParameterName, 'Run with the given packages installed')
            [CompletionResult]::new('--with-editable', '--with-editable', [CompletionResultType]::ParameterName, 'Run with the given packages installed in editable mode')
            [CompletionResult]::new('--with-requirements', '--with-requirements', [CompletionResultType]::ParameterName, 'Run with all packages listed in the given `requirements.txt` files')
            [CompletionResult]::new('--index', '--index', [CompletionResultType]::ParameterName, 'The URLs to use when resolving dependencies, in addition to the default index')
            [CompletionResult]::new('--default-index', '--default-index', [CompletionResultType]::ParameterName, 'The URL of the default package index (by default: <https://pypi.org/simple>)')
            [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, '(Deprecated: use `--default-index` instead) The URL of the Python package index (by default: <https://pypi.org/simple>)')
            [CompletionResult]::new('--index-url', '--index-url', [CompletionResultType]::ParameterName, '(Deprecated: use `--default-index` instead) The URL of the Python package index (by default: <https://pypi.org/simple>)')
            [CompletionResult]::new('--extra-index-url', '--extra-index-url', [CompletionResultType]::ParameterName, '(Deprecated: use `--index` instead) Extra URLs of package indexes to use, in addition to `--index-url`')
            [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Locations to search for candidate distributions, in addition to those found in the registry indexes')
            [CompletionResult]::new('--find-links', '--find-links', [CompletionResultType]::ParameterName, 'Locations to search for candidate distributions, in addition to those found in the registry indexes')
            [CompletionResult]::new('-P', '-P ', [CompletionResultType]::ParameterName, 'Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies `--refresh-package`')
            [CompletionResult]::new('--upgrade-package', '--upgrade-package', [CompletionResultType]::ParameterName, 'Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies `--refresh-package`')
            [CompletionResult]::new('--reinstall-package', '--reinstall-package', [CompletionResultType]::ParameterName, 'Reinstall a specific package, regardless of whether it''s already installed. Implies `--refresh-package`')
            [CompletionResult]::new('--index-strategy', '--index-strategy', [CompletionResultType]::ParameterName, 'The strategy to use when resolving against multiple index URLs')
            [CompletionResult]::new('--keyring-provider', '--keyring-provider', [CompletionResultType]::ParameterName, 'Attempt to use `keyring` for authentication for index URLs')
            [CompletionResult]::new('--resolution', '--resolution', [CompletionResultType]::ParameterName, 'The strategy to use when selecting between the different compatible versions for a given package requirement')
            [CompletionResult]::new('--prerelease', '--prerelease', [CompletionResultType]::ParameterName, 'The strategy to use when considering pre-release versions')
            [CompletionResult]::new('--fork-strategy', '--fork-strategy', [CompletionResultType]::ParameterName, 'The strategy to use when selecting multiple versions of a given package across Python versions and platforms')
            [CompletionResult]::new('-C', '-C ', [CompletionResultType]::ParameterName, 'Settings to pass to the PEP 517 build backend, specified as `KEY=VALUE` pairs')
            [CompletionResult]::new('--config-setting', '--config-setting', [CompletionResultType]::ParameterName, 'Settings to pass to the PEP 517 build backend, specified as `KEY=VALUE` pairs')
            [CompletionResult]::new('--no-build-isolation-package', '--no-build-isolation-package', [CompletionResultType]::ParameterName, 'Disable isolation when building source distributions for a specific package')
            [CompletionResult]::new('--exclude-newer', '--exclude-newer', [CompletionResultType]::ParameterName, 'Limit candidate packages to those that were uploaded prior to the given date')
            [CompletionResult]::new('--link-mode', '--link-mode', [CompletionResultType]::ParameterName, 'The method to use when installing packages from the global cache')
            [CompletionResult]::new('--no-build-package', '--no-build-package', [CompletionResultType]::ParameterName, 'Don''t build source distributions for a specific package')
            [CompletionResult]::new('--no-binary-package', '--no-binary-package', [CompletionResultType]::ParameterName, 'Don''t install pre-built wheels for a specific package')
            [CompletionResult]::new('--refresh-package', '--refresh-package', [CompletionResultType]::ParameterName, 'Refresh cached data for a specific package')
            [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'The Python interpreter to use to build the run environment.')
            [CompletionResult]::new('--python', '--python', [CompletionResultType]::ParameterName, 'The Python interpreter to use to build the run environment.')
            [CompletionResult]::new('--generate-shell-completion', '--generate-shell-completion', [CompletionResultType]::ParameterName, 'generate-shell-completion')
            [CompletionResult]::new('--cache-dir', '--cache-dir', [CompletionResultType]::ParameterName, 'Path to the cache directory')
            [CompletionResult]::new('--python-preference', '--python-preference', [CompletionResultType]::ParameterName, 'Whether to prefer uv-managed or system Python installations')
            [CompletionResult]::new('--python-fetch', '--python-fetch', [CompletionResultType]::ParameterName, 'Deprecated version of [`Self::python_downloads`]')
            [CompletionResult]::new('--color', '--color', [CompletionResultType]::ParameterName, 'Control the use of color in output')
            [CompletionResult]::new('--allow-insecure-host', '--allow-insecure-host', [CompletionResultType]::ParameterName, 'Allow insecure connections to a host')
            [CompletionResult]::new('--directory', '--directory', [CompletionResultType]::ParameterName, 'Change to the given directory prior to running the command')
            [CompletionResult]::new('--project', '--project', [CompletionResultType]::ParameterName, 'Run the command within the given project directory')
            [CompletionResult]::new('--config-file', '--config-file', [CompletionResultType]::ParameterName, 'The path to a `uv.toml` file to use for configuration')
            [CompletionResult]::new('--isolated', '--isolated', [CompletionResultType]::ParameterName, 'Run the tool in an isolated virtual environment, ignoring any already-installed tools')
            [CompletionResult]::new('--no-index', '--no-index', [CompletionResultType]::ParameterName, 'Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via `--find-links`')
            [CompletionResult]::new('-U', '-U ', [CompletionResultType]::ParameterName, 'Allow package upgrades, ignoring pinned versions in any existing output file. Implies `--refresh`')
            [CompletionResult]::new('--upgrade', '--upgrade', [CompletionResultType]::ParameterName, 'Allow package upgrades, ignoring pinned versions in any existing output file. Implies `--refresh`')
            [CompletionResult]::new('--no-upgrade', '--no-upgrade', [CompletionResultType]::ParameterName, 'no-upgrade')
            [CompletionResult]::new('--reinstall', '--reinstall', [CompletionResultType]::ParameterName, 'Reinstall all packages, regardless of whether they''re already installed. Implies `--refresh`')
            [CompletionResult]::new('--no-reinstall', '--no-reinstall', [CompletionResultType]::ParameterName, 'no-reinstall')
            [CompletionResult]::new('--pre', '--pre', [CompletionResultType]::ParameterName, 'pre')
            [CompletionResult]::new('--no-build-isolation', '--no-build-isolation', [CompletionResultType]::ParameterName, 'Disable isolation when building source distributions')
            [CompletionResult]::new('--build-isolation', '--build-isolation', [CompletionResultType]::ParameterName, 'build-isolation')
            [CompletionResult]::new('--compile-bytecode', '--compile-bytecode', [CompletionResultType]::ParameterName, 'Compile Python files to bytecode after installation')
            [CompletionResult]::new('--no-compile-bytecode', '--no-compile-bytecode', [CompletionResultType]::ParameterName, 'no-compile-bytecode')
            [CompletionResult]::new('--no-sources', '--no-sources', [CompletionResultType]::ParameterName, 'Ignore the `tool.uv.sources` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources')
            [CompletionResult]::new('--no-build', '--no-build', [CompletionResultType]::ParameterName, 'Don''t build source distributions')
            [CompletionResult]::new('--build', '--build', [CompletionResultType]::ParameterName, 'build')
            [CompletionResult]::new('--no-binary', '--no-binary', [CompletionResultType]::ParameterName, 'Don''t install pre-built wheels')
            [CompletionResult]::new('--binary', '--binary', [CompletionResultType]::ParameterName, 'binary')
            [CompletionResult]::new('--refresh', '--refresh', [CompletionResultType]::ParameterName, 'Refresh all cached data')
            [CompletionResult]::new('--no-refresh', '--no-refresh', [CompletionResultType]::ParameterName, 'no-refresh')
            [CompletionResult]::new('--show-resolution', '--show-resolution', [CompletionResultType]::ParameterName, 'Whether to show resolver and installer output from any environment modifications')
            [CompletionResult]::new('-n', '-n', [CompletionResultType]::ParameterName, 'Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation')
            [CompletionResult]::new('--no-cache', '--no-cache', [CompletionResultType]::ParameterName, 'Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation')
            [CompletionResult]::new('--allow-python-downloads', '--allow-python-downloads', [CompletionResultType]::ParameterName, 'Allow automatically downloading Python when required. [env: "UV_PYTHON_DOWNLOADS=auto"]')
            [CompletionResult]::new('--no-python-downloads', '--no-python-downloads', [CompletionResultType]::ParameterName, 'Disable automatic downloads of Python. [env: "UV_PYTHON_DOWNLOADS=never"]')
            [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Do not print any output')
            [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Do not print any output')
            [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Use verbose output')
            [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Use verbose output')
            [CompletionResult]::new('--no-color', '--no-color', [CompletionResultType]::ParameterName, 'Disable colors')
            [CompletionResult]::new('--native-tls', '--native-tls', [CompletionResultType]::ParameterName, 'Whether to load TLS certificates from the platform''s native certificate store')
            [CompletionResult]::new('--no-native-tls', '--no-native-tls', [CompletionResultType]::ParameterName, 'no-native-tls')
            [CompletionResult]::new('--offline', '--offline', [CompletionResultType]::ParameterName, 'Disable network access')
            [CompletionResult]::new('--no-offline', '--no-offline', [CompletionResultType]::ParameterName, 'no-offline')
            [CompletionResult]::new('--preview', '--preview', [CompletionResultType]::ParameterName, 'Whether to enable experimental, preview features')
            [CompletionResult]::new('--no-preview', '--no-preview', [CompletionResultType]::ParameterName, 'no-preview')
            [CompletionResult]::new('--show-settings', '--show-settings', [CompletionResultType]::ParameterName, 'Show the resolved settings for the current command')
            [CompletionResult]::new('--no-progress', '--no-progress', [CompletionResultType]::ParameterName, 'Hide all progress outputs')
            [CompletionResult]::new('--no-installer-metadata', '--no-installer-metadata', [CompletionResultType]::ParameterName, 'Skip writing `uv` installer metadata files (e.g., `INSTALLER`, `REQUESTED`, and `direct_url.json`) to site-packages `.dist-info` directories')
            [CompletionResult]::new('--no-config', '--no-config', [CompletionResultType]::ParameterName, 'Avoid discovering configuration files (`pyproject.toml`, `uv.toml`)')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Display the concise help for this command')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Display the concise help for this command')
            [CompletionResult]::new('-V', '-V ', [CompletionResultType]::ParameterName, 'Display the uv version')
            [CompletionResult]::new('--version', '--version', [CompletionResultType]::ParameterName, 'Display the uv version')
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
