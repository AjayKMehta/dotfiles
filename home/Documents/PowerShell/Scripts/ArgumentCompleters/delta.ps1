
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'delta' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'delta'
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
        'delta' {
            [CompletionResult]::new('--blame-code-style', 'blame-code-style', [CompletionResultType]::ParameterName, 'Style string for the code section of a git blame line')
            [CompletionResult]::new('--blame-format', 'blame-format', [CompletionResultType]::ParameterName, 'Format string for git blame commit metadata')
            [CompletionResult]::new('--blame-palette', 'blame-palette', [CompletionResultType]::ParameterName, 'Background colors used for git blame lines (space-separated string)')
            [CompletionResult]::new('--blame-separator-format', 'blame-separator-format', [CompletionResultType]::ParameterName, 'Separator between the blame format and the code section of a git blame line')
            [CompletionResult]::new('--blame-separator-style', 'blame-separator-style', [CompletionResultType]::ParameterName, 'Style string for the blame-separator-format')
            [CompletionResult]::new('--blame-timestamp-format', 'blame-timestamp-format', [CompletionResultType]::ParameterName, 'Format of `git blame` timestamp in raw git output received by delta')
            [CompletionResult]::new('--blame-timestamp-output-format', 'blame-timestamp-output-format', [CompletionResultType]::ParameterName, 'Format string for git blame timestamp output')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Load the config file at PATH instead of ~/.gitconfig')
            [CompletionResult]::new('--commit-decoration-style', 'commit-decoration-style', [CompletionResultType]::ParameterName, 'Style string for the commit hash decoration')
            [CompletionResult]::new('--commit-regex', 'commit-regex', [CompletionResultType]::ParameterName, 'Regular expression used to identify the commit line when parsing git output')
            [CompletionResult]::new('--commit-style', 'commit-style', [CompletionResultType]::ParameterName, 'Style string for the commit hash line')
            [CompletionResult]::new('--default-language', 'default-language', [CompletionResultType]::ParameterName, 'Default language used for syntax highlighting')
            [CompletionResult]::new('--detect-dark-light', 'detect-dark-light', [CompletionResultType]::ParameterName, 'Detect whether or not the terminal is dark or light by querying for its colors')
            [CompletionResult]::new('--diff-stat-align-width', 'diff-stat-align-width', [CompletionResultType]::ParameterName, 'Width allocated for file paths in a diff stat section')
            [CompletionResult]::new('--features', 'features', [CompletionResultType]::ParameterName, 'Names of delta features to activate (space-separated)')
            [CompletionResult]::new('--file-added-label', 'file-added-label', [CompletionResultType]::ParameterName, 'Text to display before an added file path')
            [CompletionResult]::new('--file-copied-label', 'file-copied-label', [CompletionResultType]::ParameterName, 'Text to display before a copied file path')
            [CompletionResult]::new('--file-decoration-style', 'file-decoration-style', [CompletionResultType]::ParameterName, 'Style string for the file decoration')
            [CompletionResult]::new('--file-modified-label', 'file-modified-label', [CompletionResultType]::ParameterName, 'Text to display before a modified file path')
            [CompletionResult]::new('--file-removed-label', 'file-removed-label', [CompletionResultType]::ParameterName, 'Text to display before a removed file path')
            [CompletionResult]::new('--file-renamed-label', 'file-renamed-label', [CompletionResultType]::ParameterName, 'Text to display before a renamed file path')
            [CompletionResult]::new('--file-style', 'file-style', [CompletionResultType]::ParameterName, 'Style string for the file section')
            [CompletionResult]::new('--file-transformation', 'file-transformation', [CompletionResultType]::ParameterName, 'Sed-style command transforming file paths for display')
            [CompletionResult]::new('--generate-completion', 'generate-completion', [CompletionResultType]::ParameterName, 'Print completion file for the given shell')
            [CompletionResult]::new('--grep-context-line-style', 'grep-context-line-style', [CompletionResultType]::ParameterName, 'Style string for non-matching lines of grep output')
            [CompletionResult]::new('--grep-file-style', 'grep-file-style', [CompletionResultType]::ParameterName, 'Style string for file paths in grep output')
            [CompletionResult]::new('--grep-header-decoration-style', 'grep-header-decoration-style', [CompletionResultType]::ParameterName, 'Style string for the header decoration in grep output')
            [CompletionResult]::new('--grep-header-file-style', 'grep-header-file-style', [CompletionResultType]::ParameterName, 'Style string for the file path part of the header in grep output')
            [CompletionResult]::new('--grep-line-number-style', 'grep-line-number-style', [CompletionResultType]::ParameterName, 'Style string for line numbers in grep output')
            [CompletionResult]::new('--grep-output-type', 'grep-output-type', [CompletionResultType]::ParameterName, 'Grep output format. Possible values: "ripgrep" - file name printed once, followed by matching lines within that file, each preceded by a line number. "classic" - file name:line number, followed by matching line. Default is "ripgrep" if `rg --json` format is detected, otherwise "classic"')
            [CompletionResult]::new('--grep-match-line-style', 'grep-match-line-style', [CompletionResultType]::ParameterName, 'Style string for matching lines of grep output')
            [CompletionResult]::new('--grep-match-word-style', 'grep-match-word-style', [CompletionResultType]::ParameterName, 'Style string for the matching substrings within a matching line of grep output')
            [CompletionResult]::new('--grep-separator-symbol', 'grep-separator-symbol', [CompletionResultType]::ParameterName, 'Separator symbol printed after the file path and line number in grep output')
            [CompletionResult]::new('--hunk-header-decoration-style', 'hunk-header-decoration-style', [CompletionResultType]::ParameterName, 'Style string for the hunk-header decoration')
            [CompletionResult]::new('--hunk-header-file-style', 'hunk-header-file-style', [CompletionResultType]::ParameterName, 'Style string for the file path part of the hunk-header')
            [CompletionResult]::new('--hunk-header-line-number-style', 'hunk-header-line-number-style', [CompletionResultType]::ParameterName, 'Style string for the line number part of the hunk-header')
            [CompletionResult]::new('--hunk-header-style', 'hunk-header-style', [CompletionResultType]::ParameterName, 'Style string for the hunk-header')
            [CompletionResult]::new('--hunk-label', 'hunk-label', [CompletionResultType]::ParameterName, 'Text to display before a hunk header')
            [CompletionResult]::new('--hyperlinks-commit-link-format', 'hyperlinks-commit-link-format', [CompletionResultType]::ParameterName, 'Format string for commit hyperlinks (requires --hyperlinks)')
            [CompletionResult]::new('--hyperlinks-file-link-format', 'hyperlinks-file-link-format', [CompletionResultType]::ParameterName, 'Format string for file hyperlinks (requires --hyperlinks)')
            [CompletionResult]::new('--inline-hint-style', 'inline-hint-style', [CompletionResultType]::ParameterName, 'Style string for short inline hint text')
            [CompletionResult]::new('--inspect-raw-lines', 'inspect-raw-lines', [CompletionResultType]::ParameterName, 'Kill-switch for --color-moved support')
            [CompletionResult]::new('--line-buffer-size', 'line-buffer-size', [CompletionResultType]::ParameterName, 'Size of internal line buffer')
            [CompletionResult]::new('--line-fill-method', 'line-fill-method', [CompletionResultType]::ParameterName, 'Line-fill method in side-by-side mode')
            [CompletionResult]::new('--line-numbers-left-format', 'line-numbers-left-format', [CompletionResultType]::ParameterName, 'Format string for the left column of line numbers')
            [CompletionResult]::new('--line-numbers-left-style', 'line-numbers-left-style', [CompletionResultType]::ParameterName, 'Style string for the left column of line numbers')
            [CompletionResult]::new('--line-numbers-minus-style', 'line-numbers-minus-style', [CompletionResultType]::ParameterName, 'Style string for line numbers in the old (minus) version of the file')
            [CompletionResult]::new('--line-numbers-plus-style', 'line-numbers-plus-style', [CompletionResultType]::ParameterName, 'Style string for line numbers in the new (plus) version of the file')
            [CompletionResult]::new('--line-numbers-right-format', 'line-numbers-right-format', [CompletionResultType]::ParameterName, 'Format string for the right column of line numbers')
            [CompletionResult]::new('--line-numbers-right-style', 'line-numbers-right-style', [CompletionResultType]::ParameterName, 'Style string for the right column of line numbers')
            [CompletionResult]::new('--line-numbers-zero-style', 'line-numbers-zero-style', [CompletionResultType]::ParameterName, 'Style string for line numbers in unchanged (zero) lines')
            [CompletionResult]::new('--map-styles', 'map-styles', [CompletionResultType]::ParameterName, 'Map styles encountered in raw input to desired output styles')
            [CompletionResult]::new('--max-line-distance', 'max-line-distance', [CompletionResultType]::ParameterName, 'Maximum line pair distance parameter in within-line diff algorithm')
            [CompletionResult]::new('--max-line-length', 'max-line-length', [CompletionResultType]::ParameterName, 'Truncate lines longer than this')
            [CompletionResult]::new('--merge-conflict-begin-symbol', 'merge-conflict-begin-symbol', [CompletionResultType]::ParameterName, 'String marking the beginning of a merge conflict region')
            [CompletionResult]::new('--merge-conflict-end-symbol', 'merge-conflict-end-symbol', [CompletionResultType]::ParameterName, 'String marking the end of a merge conflict region')
            [CompletionResult]::new('--merge-conflict-ours-diff-header-decoration-style', 'merge-conflict-ours-diff-header-decoration-style', [CompletionResultType]::ParameterName, 'Style string for the decoration of the header above the ''ours'' merge conflict diff')
            [CompletionResult]::new('--merge-conflict-ours-diff-header-style', 'merge-conflict-ours-diff-header-style', [CompletionResultType]::ParameterName, 'Style string for the header above the ''ours'' branch merge conflict diff')
            [CompletionResult]::new('--merge-conflict-theirs-diff-header-decoration-style', 'merge-conflict-theirs-diff-header-decoration-style', [CompletionResultType]::ParameterName, 'Style string for the decoration of the header above the ''theirs'' merge conflict diff')
            [CompletionResult]::new('--merge-conflict-theirs-diff-header-style', 'merge-conflict-theirs-diff-header-style', [CompletionResultType]::ParameterName, 'Style string for the header above the ''theirs'' branch merge conflict diff')
            [CompletionResult]::new('--minus-empty-line-marker-style', 'minus-empty-line-marker-style', [CompletionResultType]::ParameterName, 'Style string for removed empty line marker')
            [CompletionResult]::new('--minus-emph-style', 'minus-emph-style', [CompletionResultType]::ParameterName, 'Style string for emphasized sections of removed lines')
            [CompletionResult]::new('--minus-non-emph-style', 'minus-non-emph-style', [CompletionResultType]::ParameterName, 'Style string for non-emphasized sections of removed lines that have an emphasized section')
            [CompletionResult]::new('--minus-style', 'minus-style', [CompletionResultType]::ParameterName, 'Style string for removed lines')
            [CompletionResult]::new('--navigate-regex', 'navigate-regex', [CompletionResultType]::ParameterName, 'Regular expression defining navigation stop points')
            [CompletionResult]::new('--pager', 'pager', [CompletionResultType]::ParameterName, 'Which pager to use')
            [CompletionResult]::new('--paging', 'paging', [CompletionResultType]::ParameterName, 'Whether to use a pager when displaying output')
            [CompletionResult]::new('--plus-emph-style', 'plus-emph-style', [CompletionResultType]::ParameterName, 'Style string for emphasized sections of added lines')
            [CompletionResult]::new('--plus-empty-line-marker-style', 'plus-empty-line-marker-style', [CompletionResultType]::ParameterName, 'Style string for added empty line marker')
            [CompletionResult]::new('--plus-non-emph-style', 'plus-non-emph-style', [CompletionResultType]::ParameterName, 'Style string for non-emphasized sections of added lines that have an emphasized section')
            [CompletionResult]::new('--plus-style', 'plus-style', [CompletionResultType]::ParameterName, 'Style string for added lines')
            [CompletionResult]::new('--right-arrow', 'right-arrow', [CompletionResultType]::ParameterName, 'Text to display with a changed file path')
            [CompletionResult]::new('--syntax-theme', 'syntax-theme', [CompletionResultType]::ParameterName, 'The syntax-highlighting theme to use')
            [CompletionResult]::new('--tabs', 'tabs', [CompletionResultType]::ParameterName, 'The number of spaces to replace tab characters with')
            [CompletionResult]::new('--true-color', 'true-color', [CompletionResultType]::ParameterName, 'Whether to emit 24-bit ("true color") RGB color codes')
            [CompletionResult]::new('--whitespace-error-style', 'whitespace-error-style', [CompletionResultType]::ParameterName, 'Style string for whitespace errors')
            [CompletionResult]::new('-w', 'w', [CompletionResultType]::ParameterName, 'The width of underline/overline decorations')
            [CompletionResult]::new('--width', 'width', [CompletionResultType]::ParameterName, 'The width of underline/overline decorations')
            [CompletionResult]::new('--word-diff-regex', 'word-diff-regex', [CompletionResultType]::ParameterName, 'Regular expression defining a ''word'' in within-line diff algorithm')
            [CompletionResult]::new('--wrap-left-symbol', 'wrap-left-symbol', [CompletionResultType]::ParameterName, 'End-of-line wrapped content symbol (left-aligned)')
            [CompletionResult]::new('--wrap-max-lines', 'wrap-max-lines', [CompletionResultType]::ParameterName, 'How often a line should be wrapped if it does not fit')
            [CompletionResult]::new('--wrap-right-percent', 'wrap-right-percent', [CompletionResultType]::ParameterName, 'Threshold for right-aligning wrapped content')
            [CompletionResult]::new('--wrap-right-prefix-symbol', 'wrap-right-prefix-symbol', [CompletionResultType]::ParameterName, 'Pre-wrapped content symbol (right-aligned)')
            [CompletionResult]::new('--wrap-right-symbol', 'wrap-right-symbol', [CompletionResultType]::ParameterName, 'End-of-line wrapped content symbol (right-aligned)')
            [CompletionResult]::new('--zero-style', 'zero-style', [CompletionResultType]::ParameterName, 'Style string for unchanged lines')
            [CompletionResult]::new('--24-bit-color', '24-bit-color', [CompletionResultType]::ParameterName, 'Deprecated: use --true-color')
            [CompletionResult]::new('--color-only', 'color-only', [CompletionResultType]::ParameterName, 'Do not alter the input structurally in any way')
            [CompletionResult]::new('--dark', 'dark', [CompletionResultType]::ParameterName, 'Use default colors appropriate for a dark terminal background')
            [CompletionResult]::new('--diff-highlight', 'diff-highlight', [CompletionResultType]::ParameterName, 'Emulate diff-highlight')
            [CompletionResult]::new('--diff-so-fancy', 'diff-so-fancy', [CompletionResultType]::ParameterName, 'Emulate diff-so-fancy')
            [CompletionResult]::new('--hyperlinks', 'hyperlinks', [CompletionResultType]::ParameterName, 'Render commit hashes, file names, and line numbers as hyperlinks')
            [CompletionResult]::new('--keep-plus-minus-markers', 'keep-plus-minus-markers', [CompletionResultType]::ParameterName, 'Prefix added/removed lines with a +/- character, as git does')
            [CompletionResult]::new('--light', 'light', [CompletionResultType]::ParameterName, 'Use default colors appropriate for a light terminal background')
            [CompletionResult]::new('-n', 'n', [CompletionResultType]::ParameterName, 'Display line numbers next to the diff')
            [CompletionResult]::new('--line-numbers', 'line-numbers', [CompletionResultType]::ParameterName, 'Display line numbers next to the diff')
            [CompletionResult]::new('--list-languages', 'list-languages', [CompletionResultType]::ParameterName, 'List supported languages and associated file extensions')
            [CompletionResult]::new('--list-syntax-themes', 'list-syntax-themes', [CompletionResultType]::ParameterName, 'List available syntax-highlighting color themes')
            [CompletionResult]::new('--navigate', 'navigate', [CompletionResultType]::ParameterName, 'Activate diff navigation')
            [CompletionResult]::new('--no-gitconfig', 'no-gitconfig', [CompletionResultType]::ParameterName, 'Do not read any settings from git config')
            [CompletionResult]::new('--parse-ansi', 'parse-ansi', [CompletionResultType]::ParameterName, 'Display ANSI color escape sequences in human-readable form')
            [CompletionResult]::new('--raw', 'raw', [CompletionResultType]::ParameterName, 'Do not alter the input in any way')
            [CompletionResult]::new('--relative-paths', 'relative-paths', [CompletionResultType]::ParameterName, 'Output all file paths relative to the current directory')
            [CompletionResult]::new('--show-colors', 'show-colors', [CompletionResultType]::ParameterName, 'Show available named colors')
            [CompletionResult]::new('--show-config', 'show-config', [CompletionResultType]::ParameterName, 'Display the active values for all Delta options')
            [CompletionResult]::new('--show-syntax-themes', 'show-syntax-themes', [CompletionResultType]::ParameterName, 'Show example diff for available syntax-highlighting themes')
            [CompletionResult]::new('--show-themes', 'show-themes', [CompletionResultType]::ParameterName, 'Show example diff for available delta themes')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Display diffs in side-by-side layout')
            [CompletionResult]::new('--side-by-side', 'side-by-side', [CompletionResultType]::ParameterName, 'Display diffs in side-by-side layout')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('-V', 'V ', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Print version')
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
