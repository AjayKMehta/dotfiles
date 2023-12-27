
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'wezterm' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'wezterm'
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
        'wezterm' {
            [CompletionResult]::new('--config-file', 'config-file', [CompletionResultType]::ParameterName, 'Specify the configuration file to use, overrides the normal configuration file resolution')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Override specific configuration values')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Print version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Print version information')
            [CompletionResult]::new('-n', 'n', [CompletionResultType]::ParameterName, 'Skip loading wezterm.lua')
            [CompletionResult]::new('start', 'start', [CompletionResultType]::ParameterValue, 'Start the GUI, optionally running an alternative program')
            [CompletionResult]::new('ssh', 'ssh', [CompletionResultType]::ParameterValue, 'Establish an ssh session')
            [CompletionResult]::new('serial', 'serial', [CompletionResultType]::ParameterValue, 'Open a serial port')
            [CompletionResult]::new('connect', 'connect', [CompletionResultType]::ParameterValue, 'Connect to wezterm multiplexer')
            [CompletionResult]::new('ls-fonts', 'ls-fonts', [CompletionResultType]::ParameterValue, 'Display information about fonts')
            [CompletionResult]::new('show-keys', 'show-keys', [CompletionResultType]::ParameterValue, 'Show key assignments')
            [CompletionResult]::new('cli', 'cli', [CompletionResultType]::ParameterValue, 'Interact with experimental mux server')
            [CompletionResult]::new('imgcat', 'imgcat', [CompletionResultType]::ParameterValue, 'Output an image to the terminal')
            [CompletionResult]::new('set-working-directory', 'set-working-directory', [CompletionResultType]::ParameterValue, 'Advise the terminal of the current working directory by emitting an OSC 7 escape sequence')
            [CompletionResult]::new('record', 'record', [CompletionResultType]::ParameterValue, 'Record a terminal session as an asciicast')
            [CompletionResult]::new('replay', 'replay', [CompletionResultType]::ParameterValue, 'Replay an asciicast terminal session')
            [CompletionResult]::new('shell-completion', 'shell-completion', [CompletionResultType]::ParameterValue, 'Generate shell completion information')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'wezterm;start' {
            [CompletionResult]::new('--cwd', 'cwd', [CompletionResultType]::ParameterName, 'Specify the current working directory for the initially spawned program')
            [CompletionResult]::new('--class', 'class', [CompletionResultType]::ParameterName, 'Override the default windowing system class. The default is "org.wezfurlong.wezterm". Under X11 and Windows this changes the window class. Under Wayland this changes the app_id. This changes the class for all windows spawned by this instance of wezterm, including error, update and ssh authentication dialogs')
            [CompletionResult]::new('--workspace', 'workspace', [CompletionResultType]::ParameterName, 'Override the default workspace with the provided name. The default is "default"')
            [CompletionResult]::new('--position', 'position', [CompletionResultType]::ParameterName, 'Override the position for the initial window launched by this process.')
            [CompletionResult]::new('--no-auto-connect', 'no-auto-connect', [CompletionResultType]::ParameterName, 'If true, do not connect to domains marked as connect_automatically in your wezterm configuration file')
            [CompletionResult]::new('--always-new-process', 'always-new-process', [CompletionResultType]::ParameterName, 'If enabled, don''t try to ask an existing wezterm GUI instance to start the command.  Instead, always start the GUI in this invocation of wezterm so that you can wait for the command to complete by waiting for this wezterm process to finish')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;ssh' {
            [CompletionResult]::new('-o', 'o', [CompletionResultType]::ParameterName, 'Override specific SSH configuration options. `wezterm ssh` is able to parse some (but not all!) options from your `~/.ssh/config` and `/etc/ssh/ssh_config` files. This command line switch allows you to override or otherwise specify ssh_config style options')
            [CompletionResult]::new('--ssh-option', 'ssh-option', [CompletionResultType]::ParameterName, 'Override specific SSH configuration options. `wezterm ssh` is able to parse some (but not all!) options from your `~/.ssh/config` and `/etc/ssh/ssh_config` files. This command line switch allows you to override or otherwise specify ssh_config style options')
            [CompletionResult]::new('--class', 'class', [CompletionResultType]::ParameterName, 'Override the default windowing system class. The default is "org.wezfurlong.wezterm". Under X11 and Windows this changes the window class. Under Wayland this changes the app_id. This changes the class for all windows spawned by this instance of wezterm, including error, update and ssh authentication dialogs')
            [CompletionResult]::new('--position', 'position', [CompletionResultType]::ParameterName, 'Override the position for the initial window launched by this process.')
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Enable verbose ssh protocol tracing. The trace information is printed to the stderr stream of the process')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;serial' {
            [CompletionResult]::new('--baud', 'baud', [CompletionResultType]::ParameterName, 'Set the baud rate.  The default is 9600 baud')
            [CompletionResult]::new('--class', 'class', [CompletionResultType]::ParameterName, 'Override the default windowing system class. The default is "org.wezfurlong.wezterm". Under X11 and Windows this changes the window class. Under Wayland this changes the app_id. This changes the class for all windows spawned by this instance of wezterm, including error, update and ssh authentication dialogs')
            [CompletionResult]::new('--position', 'position', [CompletionResultType]::ParameterName, 'Override the position for the initial window launched by this process.')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;connect' {
            [CompletionResult]::new('--class', 'class', [CompletionResultType]::ParameterName, 'Override the default windowing system class. The default is "org.wezfurlong.wezterm". Under X11 and Windows this changes the window class. Under Wayland this changes the app_id. This changes the class for all windows spawned by this instance of wezterm, including error, update and ssh authentication dialogs')
            [CompletionResult]::new('--workspace', 'workspace', [CompletionResultType]::ParameterName, 'Override the default workspace with the provided name. The default is "default"')
            [CompletionResult]::new('--position', 'position', [CompletionResultType]::ParameterName, 'Override the position for the initial window launched by this process.')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;ls-fonts' {
            [CompletionResult]::new('--text', 'text', [CompletionResultType]::ParameterName, 'Explain which fonts are used to render the supplied text string')
            [CompletionResult]::new('--list-system', 'list-system', [CompletionResultType]::ParameterName, 'Whether to list all fonts available to the system')
            [CompletionResult]::new('--rasterize-ascii', 'rasterize-ascii', [CompletionResultType]::ParameterName, 'Show rasterized glyphs for the text in --text using ascii blocks')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;show-keys' {
            [CompletionResult]::new('--key-table', 'key-table', [CompletionResultType]::ParameterName, 'In lua mode, show only the named key table')
            [CompletionResult]::new('--lua', 'lua', [CompletionResultType]::ParameterName, 'Show the keys as lua config statements')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;cli' {
            [CompletionResult]::new('--class', 'class', [CompletionResultType]::ParameterName, 'When connecting to a gui instance, if you started the gui with `--class SOMETHING`, you should also pass that same value here in order for the client to find the correct gui instance')
            [CompletionResult]::new('--no-auto-start', 'no-auto-start', [CompletionResultType]::ParameterName, 'Don''t automatically start the server')
            [CompletionResult]::new('--prefer-mux', 'prefer-mux', [CompletionResultType]::ParameterName, 'Prefer connecting to a background mux server. The default is to prefer connecting to a running wezterm gui instance')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'list windows, tabs and panes')
            [CompletionResult]::new('list-clients', 'list-clients', [CompletionResultType]::ParameterValue, 'list clients')
            [CompletionResult]::new('proxy', 'proxy', [CompletionResultType]::ParameterValue, 'start rpc proxy pipe')
            [CompletionResult]::new('tlscreds', 'tlscreds', [CompletionResultType]::ParameterValue, 'obtain tls credentials')
            [CompletionResult]::new('move-pane-to-new-tab', 'move-pane-to-new-tab', [CompletionResultType]::ParameterValue, 'Move a pane into a new tab')
            [CompletionResult]::new('split-pane', 'split-pane', [CompletionResultType]::ParameterValue, 'split the current pane.
Outputs the pane-id for the newly created pane on success')
            [CompletionResult]::new('spawn', 'spawn', [CompletionResultType]::ParameterValue, 'Spawn a command into a new window or tab
Outputs the pane-id for the newly created pane on success')
            [CompletionResult]::new('send-text', 'send-text', [CompletionResultType]::ParameterValue, 'Send text to a pane as though it were pasted. If bracketed paste mode is enabled in the pane, then the text will be sent as a bracketed paste')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'wezterm;cli;list' {
            [CompletionResult]::new('--format', 'format', [CompletionResultType]::ParameterName, 'Controls the output format. "table" and "json" are possible formats')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;cli;list-clients' {
            [CompletionResult]::new('--format', 'format', [CompletionResultType]::ParameterName, 'Controls the output format. "table" and "json" are possible formats')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;cli;proxy' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;cli;tlscreds' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;cli;move-pane-to-new-tab' {
            [CompletionResult]::new('--pane-id', 'pane-id', [CompletionResultType]::ParameterName, 'Specify the pane that should be moved. The default is to use the current pane based on the environment variable WEZTERM_PANE')
            [CompletionResult]::new('--window-id', 'window-id', [CompletionResultType]::ParameterName, 'Specify the window into which the new tab will be created. If omitted, the window associated with the current pane is used')
            [CompletionResult]::new('--workspace', 'workspace', [CompletionResultType]::ParameterName, 'If creating a new window, override the default workspace name with the provided name.  The default name is "default"')
            [CompletionResult]::new('--new-window', 'new-window', [CompletionResultType]::ParameterName, 'Create tab in a new window, rather than the window currently containing the pane')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;cli;split-pane' {
            [CompletionResult]::new('--pane-id', 'pane-id', [CompletionResultType]::ParameterName, 'Specify the pane that should be split. The default is to use the current pane based on the environment variable WEZTERM_PANE')
            [CompletionResult]::new('--cells', 'cells', [CompletionResultType]::ParameterName, 'The number of cells that the new split should have. If omitted, 50% of the available space is used')
            [CompletionResult]::new('--percent', 'percent', [CompletionResultType]::ParameterName, 'Specify the number of cells that the new split should have, expressed as a percentage of the available space')
            [CompletionResult]::new('--cwd', 'cwd', [CompletionResultType]::ParameterName, 'Specify the current working directory for the initially spawned program')
            [CompletionResult]::new('--move-pane-id', 'move-pane-id', [CompletionResultType]::ParameterName, 'Instead of spawning a new command, move the specified pane into the newly created split')
            [CompletionResult]::new('--horizontal', 'horizontal', [CompletionResultType]::ParameterName, 'Equivalent to `--right`. If neither this nor any other direction is specified, the default is equivalent to `--bottom`')
            [CompletionResult]::new('--left', 'left', [CompletionResultType]::ParameterName, 'Split horizontally, with the new pane on the left')
            [CompletionResult]::new('--right', 'right', [CompletionResultType]::ParameterName, 'Split horizontally, with the new pane on the right')
            [CompletionResult]::new('--top', 'top', [CompletionResultType]::ParameterName, 'Split vertically, with the new pane on the top')
            [CompletionResult]::new('--bottom', 'bottom', [CompletionResultType]::ParameterName, 'Split vertically, with the new pane on the bottom')
            [CompletionResult]::new('--top-level', 'top-level', [CompletionResultType]::ParameterName, 'Rather than splitting the active pane, split the entire window')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;cli;spawn' {
            [CompletionResult]::new('--pane-id', 'pane-id', [CompletionResultType]::ParameterName, 'Specify the current pane. The default is to use the current pane based on the environment variable WEZTERM_PANE. The pane is used to determine the current domain and window')
            [CompletionResult]::new('--domain-name', 'domain-name', [CompletionResultType]::ParameterName, 'domain-name')
            [CompletionResult]::new('--window-id', 'window-id', [CompletionResultType]::ParameterName, 'Specify the window into which to spawn a tab. If omitted, the window associated with the current pane is used. Cannot be used with `--workspace` or `--new-window`')
            [CompletionResult]::new('--cwd', 'cwd', [CompletionResultType]::ParameterName, 'Specify the current working directory for the initially spawned program')
            [CompletionResult]::new('--workspace', 'workspace', [CompletionResultType]::ParameterName, 'When creating a new window, override the default workspace name with the provided name.  The default name is "default". Requires `--new-window`')
            [CompletionResult]::new('--new-window', 'new-window', [CompletionResultType]::ParameterName, 'Spawn into a new window, rather than a new tab')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;cli;send-text' {
            [CompletionResult]::new('--pane-id', 'pane-id', [CompletionResultType]::ParameterName, 'Specify the target pane. The default is to use the current pane based on the environment variable WEZTERM_PANE')
            [CompletionResult]::new('--no-paste', 'no-paste', [CompletionResultType]::ParameterName, 'Send the text directly, rather than as a bracketed paste')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;cli;help' {
            break
        }
        'wezterm;imgcat' {
            [CompletionResult]::new('--width', 'width', [CompletionResultType]::ParameterName, 'Specify the display width; defaults to "auto" which automatically selects an appropriate size.  You may also use an integer value `N` to specify the number of cells, or `Npx` to specify the number of pixels, or `N%` to size relative to the terminal width')
            [CompletionResult]::new('--height', 'height', [CompletionResultType]::ParameterName, 'Specify the display height; defaults to "auto" which automatically selects an appropriate size.  You may also use an integer value `N` to specify the number of cells, or `Npx` to specify the number of pixels, or `N%` to size relative to the terminal height')
            [CompletionResult]::new('--no-preserve-aspect-ratio', 'no-preserve-aspect-ratio', [CompletionResultType]::ParameterName, 'Do not respect the aspect ratio.  The default is to respect the aspect ratio')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;set-working-directory' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;record' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;replay' {
            [CompletionResult]::new('--explain', 'explain', [CompletionResultType]::ParameterName, 'Explain what is being sent/received')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;shell-completion' {
            [CompletionResult]::new('--shell', 'shell', [CompletionResultType]::ParameterName, 'Which shell to generate for')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help information')
            break
        }
        'wezterm;help' {
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
