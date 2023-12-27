using namespace System.Management.Automation
using namespace System.Management.Automation.Language

function New-CompletionResult {
    param([Parameter(Position = 0, ValueFromPipelineByPropertyName, Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]
        $CompletionText,

        [Parameter(Position = 1, ValueFromPipelineByPropertyName)]
        [string]
        $ToolTip = $CompletionText,

        [Parameter(Position = 2, ValueFromPipelineByPropertyName)]
        [string]
        $ListItemText = $CompletionText,

        [CompletionResultType]
        $CompletionResultType = [CompletionResultType]::ParameterValue,

        [Parameter(Mandatory = $false)]
        [switch] $NoQuotes = $false
    )

    process {
        # If the caller explicitly requests that quotes
        # not be included, via the -NoQuotes parameter,
        # then skip adding quotes.

        if ($CompletionResultType -eq [CompletionResultType]::ParameterValue -and -not $NoQuotes) {
            # Add single quotes for the caller in case they are needed.
            # We use the parser to robustly determine how it will treat
            # the argument.  If we end up with too many tokens, or if
            # the parser found something expandable in the results, we
            # know quotes are needed.

            $tokens = $null
            $null = [Parser]::ParseInput("echo $CompletionText", [ref]$tokens, [ref]$null)
            if ($tokens.Length -ne 3 -or
                ($tokens[1] -is [StringExpandableToken] -and
                    $tokens[1].Kind -eq [TokenKind]::Generic)) {
                $CompletionText = "'$CompletionText'"
            }
        }
        [CompletionResult]::new($CompletionText, $ListItemText, $CompletionResultType, $ToolTip.Trim())
    }

}