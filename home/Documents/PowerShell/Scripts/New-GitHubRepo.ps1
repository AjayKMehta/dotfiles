function New-GitHubRepo {
    param (
        [string] $Name,
        [string] $Path = '.',
        [switch] $Private
    )

    if ([string]::IsNullOrEmpty($Name)) {
        $Name = Split-Path -Leaf $Path
    }

    $visibility = $Private ? '--private' : '--public'

    gh repo create $Name $visibility -s $Path

    $repo = "AjayKMehta/$Name"
    gh repo edit $repo --enable-squash-merge --enable-issues --enable-auto-merge --delete-branch-on-merge

    gh label clone AjayKMehta/Dappery --repo $repo

    (gh label list --repo $repo --json name | ConvertFrom-Json | Select-Object -exp name) | Where-Object { $_ -cmatch '^[a-z]' } | ForEach-Object { gh label delete $_ --repo $repo --yes }
    gh secret set ACTION_USER_TOKEN -b $env:GITHUB_TOKEN --repo $repo
}
