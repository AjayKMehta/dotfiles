$stackCompleter = {
    param($wordToComplete, $commandAst, $cursorPosition)

    # Convert the current typed command elements into an array of strings
    $elements = $commandAst.CommandElements | ForEach-Object { "$_" }
    
    # Track index positions relative to Bash expectations
    $index = $elements.Count - 1
    if ($wordToComplete -eq '') {
        $index += 1
    }

    # Prepare standard completion arguments for Stack's internal parser
    $cmdline = @("--bash-completion-index", "$index")
    foreach ($arg in $elements) {
        $cmdline += @("--bash-completion-word", $arg)
    }
    if ($wordToComplete -eq '') {
        $cmdline += @("--bash-completion-word", "")
    }

    # Invoke stack with the completion arguments and filter results
    & stack $cmdline | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

Register-ArgumentCompleter -CommandName 'stack' -ScriptBlock $stackCompleter
