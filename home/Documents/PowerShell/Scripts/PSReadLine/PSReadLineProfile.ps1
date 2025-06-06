#Requires -Module @{ ModuleName = 'PSReadLine'; ModuleVersion = '2.0.0' }
using namespace Microsoft.PowerShell
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

$isVsCode = $env:TERM_PROGRAM -eq 'vscode'

#region Options

$options = @{
    AnsiEscapeTimeout             = 200
    HistoryNoDuplicates           = $true
    HistorySearchCursorMovesToEnd = $true

    HistorySaveStyle              = $isVsCode ? 'SaveNothing' : 'SaveIncrementally'
    MaximumHistoryCount           = 10000
    # HistorySavePath               = "$PSScriptRoot\PSReadLine_history.txt"

    PredictionSource              = 'HistoryAndPlugin'
}

Set-PSReadLineOption @options

## Add Dongbo's custom history handler to filter out:
## - Commands with 3 or fewer characters
## - Commands that start with a space
## - Commands that end with a semicolon
## - Start with a space or end with a semicolon if you want the command to be omitted from history
##   - Useful for filtering out sensitive commands you don't want recorded in history
$global:__defaultHistoryHandler = (Get-PSReadLineOption).AddToHistoryHandler
Set-PSReadLineOption -AddToHistoryHandler {
    param([string]$line)

    $defaultResult = $global:__defaultHistoryHandler.Invoke($line)
    if ($defaultResult -eq 'MemoryAndFile') {
        if ($line.Length -gt 3 -and $line[0] -ne ' ' -and $line[-1] -ne ';') {
            return 'MemoryAndFile'
        } else {
            return 'MemoryOnly'
        }
    }
    return $defaultResult
}

function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewline "`e[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewline "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

$colors = @{
    Command            = '#46E515'
    Comment            = '#888888'
    ContinuationPrompt = '#952E16'
    Default            = '#E6E5E5'
    Emphasis           = [ConsoleColor]::Cyan
    Error              = '#FF0000'
    Keyword            = '#16691F'
    Member             = '#FDFA1F'
    Number             = '#A000FF'
    Operator           = '#FF669C'
    Parameter          = '#FFB906'
    # `e only works in PS 6.0+
    InlinePrediction   = "`e[36;7;238m"
    Selection          = "`e[30;47m"
    String             = '#66FFBF'
    Type               = '#FFF01F'
    Variable           = '#FFB966'
}
Set-PSReadLineOption -Colors $colors
Remove-Variable colors

#endregion


#region Editing functions

# https://github.com/PowerShell/PSReadLine/issues/1643
Set-PSReadLineKeyHandler -Key Enter -Function ValidateAndAcceptLine

# Paste the clipboard text as a here string
Set-PSReadLineKeyHandler -Chord Alt+v `
    -BriefDescription PasteAsHereString `
    -LongDescription 'Paste the clipboard text as a here string' `
    -ScriptBlock {
    param($key, $arg)

    $clipboardText = Get-Clipboard
    if ($clipboardText) {
        # Remove trailing spaces, convert \r\n to \n, and remove the final \n.
        $text = $clipboardText.TrimEnd() -join "`n"
        [PSConsoleReadLine]::Insert("@'`n$text`n'@")
    } else {
        [PSConsoleReadLine]::Ding()
    }
}

if (!$isvscode) {
    Set-PSReadLineKeyHandler -Chord Ctrl+Alt+u -Function InvertCase

    # Put parentheses around the selection or entire line and move the cursor to after the closing parenthesis.
    $setPSReadLineKeyHandlerSplat = @{
        Chord            = 'Ctrl+Shift+('
        BriefDescription = 'ParenthesizeSelection'
        Description      = 'Put parentheses around the selection or entire line and move the cursor to after the closing parenthesis.'
        ScriptBlock      = {
            param($key, $arg)

            $selectionStart = $null
            $selectionLength = $null
            [PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

            $line = $null
            $cursor = $null
            [PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
            if ($selectionStart -ne -1) {
                $replacement = '(' + $line.SubString($selectionStart, $selectionLength) + ')'
                [PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $replacement)
                [PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
            } else {
                [PSConsoleReadLine]::Replace(0, $line.Length, '(' + $line + ')')
                [PSConsoleReadLine]::EndOfLine()
            }
        }
    }

    Set-PSReadLineKeyHandler @setPSReadLineKeyHandlerSplat

    Set-PSReadLineKeyHandler -Key Ctrl+Shift+l `
        -BriefDescription ToggleLowerCase `
        -LongDescription 'Convert selection to lower case' `
        -ScriptBlock {
        $selectionStart = $null
        $selectionLength = $null
        [PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

        $line = $null
        $cursor = $null
        [PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

        if ($selectionStart -ne -1) {
            [PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $line.SubString($selectionStart, $selectionLength).ToLower())
        }
    }

    Set-PSReadLineKeyHandler -Key Ctrl+Shift+u `
        -BriefDescription ToggleLowerCase `
        -LongDescription 'Convert selection to upper case' `
        -ScriptBlock {
        $selectionStart = $null
        $selectionLength = $null
        [PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

        $line = $null
        $cursor = $null
        [PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

        if ($selectionStart -ne -1) {
            [PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $line.SubString($selectionStart, $selectionLength).ToUpper())
        }
    }
}

Set-PSReadLineKeyHandler -Key '"', "'" `
    -BriefDescription SmartInsertQuote `
    -LongDescription 'Insert paired quotes if not already on a quote' `
    -ScriptBlock {
    param($key, $arg)

    $quote = $key.KeyChar

    $selectionStart = $null
    $selectionLength = $null
    [PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

    $line = $null
    $cursor = $null
    [PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    # If text is selected, just quote it without any smarts
    if ($selectionStart -ne -1) {
        [PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $quote + $line.SubString($selectionStart, $selectionLength) + $quote)
        [PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
        return
    }

    $ast = $null
    $tokens = $null
    $parseErrors = $null
    [PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$parseErrors, [ref]$null)

    function FindToken {
        param($tokens, $cursor)

        foreach ($token in $tokens) {
            if ($cursor -lt $token.Extent.StartOffset) { continue }
            if ($cursor -lt $token.Extent.EndOffset) {
                $result = $token
                $token = $token -as [StringExpandableToken]
                if ($token) {
                    $nested = FindToken $token.NestedTokens $cursor
                    if ($nested) { $result = $nested }
                }

                return $result
            }
        }
        return $null
    }

    $token = FindToken $tokens $cursor

    # If we're on or inside a **quoted** string token (so not generic), we need to be smarter
    if ($token -is [StringToken] -and $token.Kind -ne [TokenKind]::Generic) {
        # If we're at the start of the string, assume we're inserting a new string
        if ($token.Extent.StartOffset -eq $cursor) {
            [PSConsoleReadLine]::Insert("$quote$quote ")
            [PSConsoleReadLine]::SetCursorPosition($cursor + 1)
            return
        }

        # If we're at the end of the string, move over the closing quote if present.
        if ($token.Extent.EndOffset -eq ($cursor + 1) -and $line[$cursor] -eq $quote) {
            [PSConsoleReadLine]::SetCursorPosition($cursor + 1)
            return
        }
    }

    if ($null -eq $token -or
        $token.Kind -eq [TokenKind]::RParen -or $token.Kind -eq [TokenKind]::RCurly -or $token.Kind -eq [TokenKind]::RBracket) {
        if ($line[0..$cursor].Where{ $_ -eq $quote }.Count % 2 -eq 1) {
            # Odd number of quotes before the cursor, insert a single quote
            [PSConsoleReadLine]::Insert($quote)
        } else {
            # Insert matching quotes, move cursor to be in between the quotes
            [PSConsoleReadLine]::Insert("$quote$quote")
            [PSConsoleReadLine]::SetCursorPosition($cursor + 1)
        }
        return
    }

    # If cursor is at the start of a token, enclose it in quotes.
    if ($token.Extent.StartOffset -eq $cursor) {
        if ($token.Kind -eq [TokenKind]::Generic -or $token.Kind -eq [TokenKind]::Identifier -or
            $token.Kind -eq [TokenKind]::Variable -or $token.TokenFlags.hasFlag([TokenFlags]::Keyword)) {
            $end = $token.Extent.EndOffset
            $len = $end - $cursor
            [PSConsoleReadLine]::Replace($cursor, $len, $quote + $line.SubString($cursor, $len) + $quote)
            [PSConsoleReadLine]::SetCursorPosition($end + 2)
            return
        }
    }

    # We failed to be smart, so just insert a single quote
    [PSConsoleReadLine]::Insert($quote)
}

# This example will replace any aliases on the command line with the resolved commands.
Set-PSReadLineKeyHandler -Key 'Alt+%' `
    -BriefDescription ExpandAliases `
    -LongDescription 'Replace all aliases with the full command' `
    -ScriptBlock {
    param($key, $arg)

    $ast = $null
    $tokens = $null
    $errors = $null
    $cursor = $null
    [PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

    $startAdjustment = 0
    foreach ($token in $tokens) {
        if ($token.TokenFlags -band [TokenFlags]::CommandName) {
            $alias = $ExecutionContext.InvokeCommand.GetCommand($token.Extent.Text, 'Alias')
            if ($alias -ne $null) {
                $resolvedCommand = $alias.ResolvedCommandName
                if ($resolvedCommand -ne $null) {
                    $extent = $token.Extent
                    $length = $extent.EndOffset - $extent.StartOffset
                    [PSConsoleReadLine]::Replace(
                        $extent.StartOffset + $startAdjustment,
                        $length,
                        $resolvedCommand)

                    # Our copy of the tokens won't have been updated, so we need to
                    # adjust by the difference in length
                    $startAdjustment += ($resolvedCommand.Length - $length)
                }
            }
        }
    } }

# Mapped to RevertLine
Remove-PSReadLineKeyHandler -Key 'Escape'

# Mapped to BackwardKillWord
Remove-PSReadLineKeyHandler -Key 'Ctrl+w'

Set-PSReadLineKeyHandler -Key 'Alt+r' -Function RevertLine
Set-PSReadLineKeyHandler -Key 'Escape,r' -Function RevertLine

Set-PSReadLineKeyHandler -Key 'Ctrl+u' -Function BackwardKillInput
Set-PSReadLineKeyHandler -Key 'Escape,c' -Function CapitalizeWord

Set-PSReadLineKeyHandler -Key 'Ctrl+d' -Function DeleteCharOrExit

Set-PSReadLineKeyHandler -Key 'Alt+l' -Function DowncaseWord
Set-PSReadLineKeyHandler -Key 'Escape,l' -Function DowncaseWord

Set-PSReadLineKeyHandler -Key 'Escape,d' -Function KillWord

Set-PSReadLineKeyHandler -Key 'Alt+u' -Function UpcaseWord
Set-PSReadLineKeyHandler -Key 'Escape,u' -Function UpcaseWord

Set-PSReadLineKeyHandler -Key 'Ctrl+g' -Function Abort
Set-PSReadLineKeyHandler -Key 'Ctrl+o' -Function AcceptAndGetNext

Set-PSReadLineKeyHandler -Key 'Ctrl+y' -Function Yank
#endregion

#region Cursor movement functions

Set-PSReadLineKeyHandler -Key Alt+b -Function ShellBackwardWord
Set-PSReadLineKeyHandler -Key Alt+f -Function ShellForwardWord

#endregion

#region History functions

Set-PSReadLineKeyHandler -Key Ctrl+b -Function BeginningOfHistory

# Save current line in history but do not execute
Set-PSReadLineKeyHandler -Chord 'Alt+h' `
    -BriefDescription SaveInHistory `
    -LongDescription 'Save current line in history but do not execute' `
    -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    $SaveStyle = (Get-PSReadLineOption).HistorySaveStyle
    $saveInc = $SaveStyle -eq [HistorySaveStyle]::SaveIncrementally
    try {
        if (!$saveInc) {
            Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
        }
        [PSConsoleReadLine]::AddToHistory($line)
    } finally {
        if (!$saveInc) {
            Set-PSReadLineOption -HistorySaveStyle $SaveStyle
        }
    }
    [PSConsoleReadLine]::RevertLine()
}

if (!$isVsCode) {
    # This key handler shows the entire or filtered history using Out-GridView. The
    # typed text is used as the substring pattern for filtering. A selected command
    # is inserted to the command line without invoking. Multiple command selection
    # is supported, e.g. selected by Ctrl + Click.
    Set-PSReadLineKeyHandler -Chord 'Alt+F7' `
        -BriefDescription History `
        -LongDescription 'Show command history' `
        -ScriptBlock {
        $pattern = $null
        [PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
        if ($pattern) {
            $pattern = [regex]::Escape($pattern)
        }

        $history = [System.Collections.ArrayList]@(
            $last = ''
            $lines = ''
            foreach ($line in [System.IO.File]::ReadLines((Get-PSReadLineOption).HistorySavePath)) {
                if ($line.EndsWith('`')) {
                    $line = $line.Substring(0, $line.Length - 1)
                    $lines = if ($lines) {
                        "$lines`n$line"
                    } else {
                        $line
                    }
                    continue
                }

                if ($lines) {
                    $line = "$lines`n$line"
                    $lines = ''
                }

                if (($line -cne $last) -and (!$pattern -or ($line -match $pattern))) {
                    $last = $line
                    $line
                }
            }
        )
        $history.Reverse()

        $command = $history | Out-GridView -Title History -PassThru
        if ($command) {
            [PSConsoleReadLine]::RevertLine()
            [PSConsoleReadLine]::Insert(($command -join "`n"))
        }
    }

    function ocgv_history {
        param(
            [parameter(Mandatory = $true)]
            [Boolean]
            $global
        )

        $line = $null
        $cursor = $null
        [PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
        if ($global) {
            # Global history
            $history = [PSConsoleReadLine]::GetHistoryItems().CommandLine
            # reverse the items so most recent is on top
            [array]::Reverse($history)
            $selection = $history | Select-Object -Unique | Out-ConsoleGridView -OutputMode Single -Filter $line -Title 'Global Command Line History'

        } else {
            # Local history
            $history = Get-History | Sort-Object -Descending -Property Id -Unique | Select-Object CommandLine -ExpandProperty CommandLine
            $selection = $history | Out-ConsoleGridView -OutputMode Single -Filter $line -Title 'Command Line History'
        }

        if ($selection) {
            [PSConsoleReadLine]::DeleteLine()
            [PSConsoleReadLine]::Insert($selection)
            if ($selection.StartsWith($line)) {
                [PSConsoleReadLine]::SetCursorPosition($cursor)
            } else {
                [PSConsoleReadLine]::SetCursorPosition($selection.Length)
            }
        }
    }

    # When F7 is pressed, show the local command line history in OCGV
    $parameters = @{
        Key              = 'F7'
        BriefDescription = 'Show Matching History'
        LongDescription  = 'Show Matching History using Out-ConsoleGridView'
        ScriptBlock      = {
            ocgv_history -Global $false
        }
    }
    Set-PSReadLineKeyHandler @parameters

    # When Shift-F7 is pressed, show the local command line history in OCGV
    $parameters = @{
        Key              = 'Shift-F7'
        BriefDescription = 'Show Matching Global History'
        LongDescription  = 'Show Matching History for all PowerShell instances using Out-ConsoleGridView'
        ScriptBlock      = {
            ocgv_history -Global $true
        }
    }
    Set-PSReadLineKeyHandler @parameters

    Set-PSReadLineKeyHandler -Key Alt+s `
        -BriefDescription ToggleSaveHistory `
        -LongDescription 'Toggle saving history' `
        -ScriptBlock {
        switch ((Get-PSReadLineOption).HistorySaveStyle) {
            'SaveIncrementally' {
                Set-PSReadLineOption -HistorySaveStyle SaveNothing
            }
            'SaveNothing' {
                Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
            }
        }
    }
}

# https://www.petri.com/let-psreadline-handle-powershell-part-2
Set-PSReadLineKeyHandler -Chord Ctrl+h -BriefDescription 'Open PSReadlineHistory' -ScriptBlock {
    Invoke-Item -Path "$((Get-PSReadLineOption).HistorySavePath)"
}

#endregion

#region Predictive IntelliSense functions

if (!$isVsCode) {
    Set-PSReadLineKeyHandler -Chord Alt+1 -Function AcceptSuggestion
    Set-PSReadLineKeyHandler -Chord Alt+2 -Function AcceptNextSuggestionWord
}

# `ForwardChar` accepts the entire suggestion text when the cursor is at the end of the line.
# This custom binding makes `RightArrow` behave similarly - accepting the next word instead of the entire suggestion text.
Set-PSReadLineKeyHandler -Key RightArrow `
    -BriefDescription ForwardCharAndAcceptNextSuggestionWord `
    -LongDescription "Move cursor one character to the right in the current editing line and accept the next word in suggestion when it's at the end of current editing line" `
    -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ($cursor -lt $line.Length) {
        [PSConsoleReadLine]::ForwardChar($key, $arg)
    } else {
        [PSConsoleReadLine]::AcceptNextSuggestionWord($key, $arg)
    }
}

#endregion

#region Cmdlet help functions

Set-PSReadLineKeyHandler -Key Shift+F1 -BriefDescription 'OnlineCommandHelp' -LongDescription 'Open online help for the current command' -ScriptBlock {
    param($key, $arg)

    $ast = $null
    $tokens = $null
    $errors = $null
    $cursor = $null
    [PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

    $commandAst = $ast.FindAll( {
            $node = $args[0]
            $node -is [System.Management.Automation.Language.CommandAst] -and
            $node.Extent.StartOffset -le $cursor -and
            $node.Extent.EndOffset -ge $cursor
        }, $true) | Select-Object -Last 1

    if ($commandAst) {
        $commandName = $commandAst.GetCommandName()
        if ($commandName) {
            $command = $ExecutionContext.InvokeCommand.GetCommand($commandName, 'All')
            if ($command -is [System.Management.Automation.AliasInfo]) {
                $commandName = $command.ResolvedCommandName
            }

            if ($commandName) {
                Get-Help $commandName -Online
            }
        }
    }
}

if (!$isVsCode) {
    Set-PSReadLineKeyHandler -Key Alt+F1 -BriefDescription 'CommandHelp' -LongDescription 'Open the help window for the current command' -ScriptBlock {
        param($key, $arg)

        $ast = $null
        $tokens = $null
        $errors = $null
        $cursor = $null
        [PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

        $commandAst = $ast.FindAll( {
                $node = $args[0]
                $node -is [System.Management.Automation.Language.CommandAst] -and
                $node.Extent.StartOffset -le $cursor -and
                $node.Extent.EndOffset -ge $cursor
            }, $true) | Select-Object -Last 1

        if ($commandAst) {
            $commandName = $commandAst.GetCommandName()
            if ($commandName) {
                $command = $ExecutionContext.InvokeCommand.GetCommand($commandName, 'All')
                if ($command -is [System.Management.Automation.AliasInfo]) {
                    $commandName = $command.ResolvedCommandName
                }

                if ($commandName) {
                    Get-Help $commandName -ShowWindow
                }
            }
        }
    }
}
#endregion

#region Selection functions

Set-PSReadLineKeyHandler -Key Alt+B -Function SelectShellBackwardWord
Set-PSReadLineKeyHandler -Key Alt+F -Function SelectShellForwardWord

#endregion

#region Miscellaneous functions

Set-PSReadLineKeyHandler -Function ShowKeyBindings -Chord 'Shift+Ctrl+?'
Set-PSReadLineKeyHandler -Function ShowKeyBindings -Chord 'Escape,?'
Set-PSReadLineKeyHandler -Function WhatIsKey -Chord 'Escape,/'

if (!$isVsCode) {
    Set-PSReadLineKeyHandler -Chord 'Ctrl+k' -Function CaptureScreen
}

#endregion

# https://github.com/sigoden/aichat/blob/main/scripts/shell-integration/integration.ps1
Set-PSReadLineKeyHandler -Chord "alt+e" -ScriptBlock {
    $_old = $null
    [Microsoft.PowerShell.PSConsoleReadline]::GetBufferState([ref]$_old, [ref]$null)
    if ($_old) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert('⌛')
        $_new = (aichat -e $_old)
        [Microsoft.PowerShell.PSConsoleReadLine]::DeleteLine()
        [Microsoft.PowerShell.PSConsoleReadline]::Insert($_new)
    }
}
