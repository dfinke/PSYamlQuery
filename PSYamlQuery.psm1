$script:yqFound = $false

if ($null -ne (Get-Command yq -ErrorAction SilentlyContinue)) {
    $script:yqFound = $true
}

function Test-YQInstalled {
    $script:yqFound -eq $true
}

function CheckYQIsInstalled {
    if (!(Test-YQInstalled)) {
        $msg = @"
YQ is not installed. You can install it using:
`choco install yq`

Or, check here:
https://mikefarah.gitbook.io/yq/#install
"@
        throw $msg
    }
}

. $PSScriptRoot\CompareYaml.ps1
. $PSScriptRoot\ConvertToYaml.ps1
. $PSScriptRoot\ImportYaml.ps1
. $PSScriptRoot\MergeYaml.ps1
. $PSScriptRoot\UpdateYaml.ps1